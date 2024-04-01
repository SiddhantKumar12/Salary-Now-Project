import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salarynow/dashboard/network/api/dashboard_api.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../storage/local_storage.dart';
import '../../../utils/written_text.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());
  String appVersion = "";

  static DashboardCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future<void> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  Future getDashBoardData() async {
    try {
      emit(DashboardLoading());
      final res = await api.getDashBoardData();
      if (res.response.statusCode == 200) {
        DashBoardModal model = DashBoardModal.fromJson(res.data);
        MyStorage.setDashBoardData(DashBoardModal.fromJson(res.data));

        emit(DashboardLoaded(dashBoardModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(DashboardError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(DashboardError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(DashboardError(error: MyWrittenText.somethingWrong));
    }
  }
}
