import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salarynow/dashboard/network/modal/app_version_modal.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../utils/written_text.dart';
import '../../network/api/dashboard_api.dart';
part 'app_version_state.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit() : super(AppVersionInitial()) {
    getAppVersion();
  }

  static AppVersionCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: false).sendRequest);

  Future getAppVersion() async {
    try {
      emit(AppVersionLoading());

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;

      final res = await api.getAppVersion();

      if (res.response.statusCode == 200) {
        AppVersionModal model = AppVersionModal.fromJson(res.data);
        emit(AppVersionLoaded(appVersionModal: model, appVersion: version));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(AppVersionError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(AppVersionError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(AppVersionError(error: MyWrittenText.somethingWrong));
    }
  }
}
