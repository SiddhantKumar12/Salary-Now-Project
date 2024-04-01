import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/storage/local_storage.dart';
import '../../dashboard/network/api/dashboard_api.dart';
import '../network/app_status_modal.dart';
import '../../service_helper/api/dio_api.dart';
import '../../service_helper/error_helper.dart';
import '../../service_helper/modal/error_modal.dart';
import '../../storage/local_storage_strings.dart';
import '../../storage/local_user_modal.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState()) {
    splashRunTime(const Duration(seconds: 5));
  }

  LocalUserModal? localUserModal = MyStorage.getUserData();
  final api = DashboardAPi(DioApi(isHeader: false).sendRequest);

  splashRunTime(Duration duration) async {
    try {
      // emit(AppStatusLoading());
      final res = await api.getAppStatus();

      if (res.response.statusCode == 200) {
        AppStatusModal model = AppStatusModal.fromJson(res.data);

        bool isLoggedIn = localUserModal?.responseData?.id != null ? true : false;
        bool isUserOnBoard = MyStorage.readData(MyStorageString.isUserOnBoard) ?? false;
        await Future.delayed(duration);

        emit(SplashLoadedState(isLoggedIn: isLoggedIn, isUserOnBoard: isUserOnBoard, appStatusModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        await Future.delayed(duration);

        emit(SplashErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      await Future.delayed(duration);

      emit(SplashErrorState(error: handleDioError(e).toString()));
    }
  }
}
