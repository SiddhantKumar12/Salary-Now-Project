import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/service_helper/api/dio_api.dart';
import 'package:salarynow/service_helper/error_helper.dart';
import 'package:salarynow/storage/local_user_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../service_helper/modal/error_modal.dart';
import '../../storage/local_storage.dart';
import '../network/api/auth_api.dart';
import '../network/modal/loginVerifyModal.dart';
import '../network/modal/login_modal.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final api = AuthApi(DioApi(isHeader: false).sendRequest);

  Future loginUser({required String mobileNumber, required String imei, required bool isLoginPage}) async {
    try {
      emit(LoginLoadingState());
      final res = await api.loginUser({'mobile': mobileNumber, 'imei': imei});
      if (res.response.statusCode == 200) {
        LoginModal model = LoginModal.fromJson(res.data);
        if (isLoginPage) {
          emit(LoginLoadedState(model));
        } else {
          emit(LoginLoadedOtpState(model));
        }
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LoginErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(LoginErrorState(handleDioError(e).toString()));
    } catch (e) {
      emit(LoginErrorState(MyWrittenText.somethingWrong));
    }
  }

  Future verifyUser({required String mobileNumber, required String otp}) async {
    try {
      emit(OtpLoadingState());
      final res = await api.verifyUser({'mobile': mobileNumber, 'otp': otp});

      if (res.response.statusCode == 200) {
        LoginVerifyModal model = LoginVerifyModal.fromJson(res.data);
        MyStorage.setUserData(LocalUserModal.fromJson(res.data));
        emit(OtpLoadedState(loginVerifyModal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(OtpErrorState(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(OtpErrorState(handleDioError(e).toString()));
    } catch (e) {
      emit(OtpErrorState(MyWrittenText.somethingWrong));
    }
  }
}
