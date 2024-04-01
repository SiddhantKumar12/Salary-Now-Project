import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salarynow/registration/network/api/registration_api.dart';
import 'package:salarynow/registration/network/modal/employment_type.dart';
import 'package:salarynow/registration/network/modal/registraion_modal.dart';
import 'package:salarynow/service_helper/api/dio_api.dart';
import 'package:salarynow/service_helper/error_helper.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../form_helper/network/modal/city_modal.dart';
import '../../form_helper/network/modal/state_modal.dart';
import '../../service_helper/modal/error_modal.dart';
import '../../storage/local_storage.dart';
import '../../storage/local_user_modal.dart';
import '../network/modal/pin_code_modal.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  static RegistrationCubit get(context) => BlocProvider.of(context);

  final api = RegistrationApi(DioApi(isHeader: false).sendRequest);

  Future registerUser({
    required String name,
    required String mobile,
    required String panCardNo,
    required String cityLocation,
    required String stateLocation,
    required String pinCode,
    required String email,
    required String dob,
    required String employmentType,
    required String imei,
  }) async {
    var data = {
      "name": name,
      "mobile": mobile,
      "pan_no": panCardNo,
      "city_location": cityLocation,
      "state_location": stateLocation,
      "pincode_location": pinCode,
      "email": email,
      "dob": dob,
      "employment_type": employmentType,
      "imei": imei
    };
    try {
      emit(RegistrationLoadingState());
      final res = await api.registerUser(data);

      if (res.response.statusCode == 200) {
        RegistrationModal model = RegistrationModal.fromJson(res.data);
        MyStorage.setUserData(LocalUserModal.fromJson(res.data));
        emit(RegistrationLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(RegistrationErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(RegistrationErrorState(handleDioError(e).toString()));
    } catch (e) {
      emit(RegistrationErrorState(MyWrittenText.somethingWrong));
    }
  }

  Future postPinCode({required String pinCode}) async {
    try {
      emit(PinCodeLoadingState());
      final res = await api.postPinCode({"pincode": pinCode});

      if (res.response.statusCode == 200) {
        PinCodeModal model = PinCodeModal.fromJson(res.data);
        emit(PinCodeLoadedState(model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PinCodeErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PinCodeErrorState(handleDioError(e).toString()));
    } catch (e) {
      emit(PinCodeErrorState(MyWrittenText.somethingWrong));
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

  /// City Api
  Future postCity({
    String? stateId,
  }) async {
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

  void setDate(DateTime date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    emit(DatePickerState(selectedDate: formattedDate));
  }

  validateDate(String? value) {
    if (value == null || value.isEmpty) {
      emit(DateErrorState(error: 'Please select a date'));
    } else {
      emit(DateErrorState(error: null));
    }
  }
}
