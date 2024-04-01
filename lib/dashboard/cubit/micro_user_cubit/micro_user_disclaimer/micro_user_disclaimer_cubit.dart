import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/check_micro_user/check_micro_user_cubit.dart';
import 'package:salarynow/dashboard/network/modal/micro_user_disclaimer_modal.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../../service_helper/modal/error_modal.dart';
import '../../../network/api/dashboard_api.dart';

part 'micro_user_disclaimer_state.dart';

class MicroUserDisclaimerCubit extends Cubit<MicroUserDisclaimerState> {
  MicroUserDisclaimerCubit() : super(MicroUserDisclaimerInitial());

  static MicroUserDisclaimerCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future postMicroDisclaimer({required String loanId}) async {
    try {
      emit(MicroUserDisclaimerLoading());
      final res = await api.postMicroDisclaimer({"loanId": loanId});

      if (res.response.statusCode == 200) {
        MicroUserDisclaimerModal model = MicroUserDisclaimerModal.fromJson(res.data);
        emit(MicroUserDisclaimerLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(MicroUserDisclaimerError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(MicroUserDisclaimerError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(MicroUserDisclaimerError(error: MyWrittenText.somethingWrong));
    }
  }
}
