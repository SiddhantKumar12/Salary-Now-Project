import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../network/api/dashboard_api.dart';
import '../micro_user_post_disclaimer/micro_user_post_disclaimer_cubit.dart';

part 'micro_user_save_state.dart';

class MicroUserSaveCubit extends Cubit<MicroUserSaveState> {
  MicroUserSaveCubit() : super(MicroUserSaveInitial());

  static MicroUserSaveCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future postMicroUserSave({
    required String loanId,
    required String name,
    required String dob,
    required String gender,
    required String martialStatus,
    required String relationBorrower,
    required String panNumber,
    required String aadhaarNumber,
    required String occupation,
    required String religion,
    required String address,
    required String pinCode,
    required String income,
  }) async {
    try {
      emit(MicroUserSaveLoading());

      var data = {
        "loanId": loanId,
        "name": name,
        "dob": dob,
        "gender": gender,
        "marital_status": martialStatus,
        "relation_borrower": relationBorrower,
        "pan_no": panNumber,
        "aadhar_no": aadhaarNumber,
        "occupation": occupation,
        "religion": religion,
        "address": address,
        "pincode": pinCode,
        "income": income
      };
      final res = await api.postMicroUserSave(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(MicroUserSaveLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(MicroUserSaveError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(MicroUserSaveError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(MicroUserSaveError(error: MyWrittenText.somethingWrong));
    }
  }
}
