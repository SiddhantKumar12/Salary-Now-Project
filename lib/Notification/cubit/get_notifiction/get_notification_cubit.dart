import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../dashboard/network/api/dashboard_api.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/modal/get_notification_modal.dart';

part 'get_notification_state.dart';

class GetNotificationCubit extends Cubit<GetNotificationState> {
  GetNotificationCubit() : super(GetNotificationInitial()) {
    getNotification();
  }

  static GetNotificationCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getNotification() async {
    try {
      emit(GetNotificationLoading());
      final res = await api.getNotification();

      if (res.response.statusCode == 200) {
        NotificationGetModal model = NotificationGetModal.fromJson(res.data);
        emit(GetNotificationLoaded(notificationGetModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(GetNotificationError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(GetNotificationError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(GetNotificationError(error: MyWrittenText.somethingWrong));
    }
  }
}
