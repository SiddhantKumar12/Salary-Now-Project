import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/information/network/api/personal_detail_api/personal_details_api.dart';
import 'package:salarynow/information/network/modal/personal_info_modal.dart';
import 'package:salarynow/service_helper/error_helper.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/modal/error_modal.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial()) {
    getPersonalDetails();
  }

  static PersonalInfoCubit get(context) => BlocProvider.of(context);

  final api = PersonalDetailsApi(DioApi(isHeader: true).sendRequest);

  Future getPersonalDetails() async {
    try {
      emit(PersonalInfoLoading());
      final res = await api.getPersonalDetails();

      if (res.response.statusCode == 200) {
        PersonalDetailsModal model = PersonalDetailsModal.fromJson(res.data);
        emit(PersonalInfoLoaded(personalDetailsModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PersonalInfoError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PersonalInfoError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(PersonalInfoError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getPersonalDetails();

    return super.close();
  }
}
