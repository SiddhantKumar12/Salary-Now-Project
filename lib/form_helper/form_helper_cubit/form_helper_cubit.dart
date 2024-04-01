import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salarynow/form_helper/network/api/form_helper_api.dart';
import 'package:salarynow/form_helper/network/modal/city_modal.dart';
import 'package:salarynow/form_helper/network/modal/ifsc_modal.dart';
import 'package:salarynow/form_helper/network/modal/salary_mode.dart';
import 'package:salarynow/form_helper/network/modal/state_modal.dart';
import 'package:salarynow/service_helper/api/dio_api.dart';
import 'package:salarynow/service_helper/error_helper.dart';
import 'package:salarynow/storage/local_storage.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../registration/network/modal/employment_type.dart';
import '../../registration/network/modal/pin_code_modal.dart';
import '../../service_helper/modal/error_modal.dart';
import '../network/modal/user_common_modal.dart';
part 'form_helper_state.dart';

class FormHelperApiCubit extends Cubit<FormHelperApiState> {
  FormHelperApiCubit() : super(FormHelperApiInitial()) {}

  static FormHelperApiCubit get(context) => BlocProvider.of(context);

  final api = FormHelperApi(DioApi(isHeader: false).sendRequest);

  /// Employment type
  Future getEmploymentType() async {
    try {
      emit(EmpLoadingState());
      final res = await api.getEmploymentType();

      if (res.response.statusCode == 200) {
        EmploymentTypeModal model = EmploymentTypeModal.fromJson(res.data);
        MyStorage.setEmploymentType(model);
        emit(EmpTypeLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(EmpTypeErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(EmpTypeErrorState(handleDioError(e).toString()));
    } catch (e) {
      emit(EmpTypeErrorState(MyWrittenText.somethingWrong));
    }
  }

  /// State List
  Future getState() async {
    try {
      emit(StateLoadingState());
      final res = await api.getState();

      if (res.response.statusCode == 200) {
        StateModal model = StateModal.fromJson(res.data);
        MyStorage.setStateData(model);
        emit(StateLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(StateErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(StateErrorState(error: handleDioError(e).toString()));
    } catch (e) {
      emit(StateErrorState(error: MyWrittenText.somethingWrong));
    }
  }

  /// Salary Mode
  Future getSalaryModeList() async {
    try {
      emit(SalaryModeLoadingState());
      final res = await api.getSalaryMode();

      if (res.response.statusCode == 200) {
        SalaryModal model = SalaryModal.fromJson(res.data);
        MyStorage.setSalaryMode(model);
        emit(SalaryModeLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(SalaryModeErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(SalaryModeErrorState(error: handleDioError(e).toString()));
    }
  }

  /// User Common
  Future getUserCommonList() async {
    try {
      emit(UserCommonLoadingState());
      final res = await api.getUserCommon();

      if (res.response.statusCode == 200) {
        UserCommonModal model = UserCommonModal.fromJson(res.data);
        MyStorage.setUserCommonData(model);
        emit(UserCommonLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(UserCommonErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(UserCommonErrorState(error: handleDioError(e).toString()));
    }
  }

  /// pinCode Api
  Future postPinCode({String? pinCode}) async {
    try {
      emit(PinCodeeLoadingState());
      final res = await api.postPinCode({"pincode": pinCode});

      if (res.response.statusCode == 200) {
        PinCodeModal model = PinCodeModal.fromJson(res.data);
        emit(PinCodeeLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PinCodeeErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PinCodeeErrorState(handleDioError(e).toString()));
    }
  }

  /// City Api
  Future postCity({String? stateId, bool secondCity = false}) async {
    if (secondCity == true) {
      try {
        emit(SecondCityLoadingState());
        final res = await api.postCityId({"state_id": stateId});

        if (res.response.statusCode == 200) {
          CityModal model = CityModal.fromJson(res.data);
          emit(SecondCityLoadedState(model));
        } else {
          ErrorModal errorModal = ErrorModal.fromJson(res.data);
          emit(SecondCityErrorState(error: errorModal.responseMsg.toString()));
        }
      } on DioError catch (e) {
        emit(SecondCityErrorState(error: handleDioError(e).toString()));
      }
    } else {
      try {
        emit(CityLoadingState());
        final res = await api.postCityId({"state_id": stateId});
        if (res.response.statusCode == 200) {
          CityModal model = CityModal.fromJson(res.data);
          emit(CityLoadedState(model));
        } else {
          ErrorModal errorModal = ErrorModal.fromJson(res.data);
          emit(CityErrorState(error: errorModal.responseMsg.toString()));
        }
      } on DioError catch (e) {
        emit(CityErrorState(error: handleDioError(e).toString()));
      }
    }
  }

  /// Ifsc Api
  Future postIfsc({String? ifsc}) async {
    try {
      emit(IfscLoadingState());
      final res = await api.postifsc({"ifsc": ifsc});

      if (res.response.statusCode == 200) {
        IfscModal model = IfscModal.fromJson(res.data);
        emit(IfscLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(IfscErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(IfscErrorState(handleDioError(e).toString()));
    }
  }

  void setDate(DateTime date) {
    emit(DatePickerLoading());
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    emit(DatePickerLoaded(selectedDate: formattedDate));
  }

  @override
  Future<void> close() {
    getUserCommonList();
    getSalaryModeList();
    getEmploymentType();
    postPinCode();
    postCity();
    postIfsc();
    return super.close();
  }
}
