import 'package:call_log/call_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../api/permission_api.dart';
import '../../network/call_log_modal.dart';

part 'call_logs_state.dart';

class CallLogsCubit extends Cubit<CallLogsState> {
  CallLogsCubit() : super(CallLogsInitial());

  static CallLogsCubit get(context) => BlocProvider.of(context);

  final api = PermissionApi(DioApi(isHeader: true).sendRequest);

  Future<void> fetchCallLogsAndPostToAPI() async {
    emit(CallLogLoading());
    PermissionStatus permissionStatus = await Permission.phone.request();

    if (permissionStatus.isGranted) {
      try {
        Iterable<CallLogEntry> callLogEntries = await CallLog.query();
        List<MyCallLogModal> callLogData = [];
        for (var entry in callLogEntries) {
          callLogData.add(MyCallLogModal(
              type: entry.callType.toString(),
              date: entry.timestamp != null ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!).toString() : 'None',
              duration: entry.duration.toString(),
              name: entry.name,
              phone: entry.number));
        }

        var data = {"row_data": callLogData, "num_of_count": callLogData.length, "action_type": "call_logs"};

        final res = await api.postPermissionData(data);

        if (res.response.statusCode == 200) {
          ErrorModal successModal = ErrorModal.fromJson(res.data);
          emit(CallLogLoaded(message: successModal.responseMsg.toString()));
        } else {
          ErrorModal errorModal = ErrorModal.fromJson(res.data);
          emit(CallLogError(errorMessage: errorModal.responseMsg.toString()));
        }
      } on DioError catch (e) {
        emit(CallLogError(errorMessage: handleDioError(e).toString()));
      } catch (e) {
        emit(CallLogError(errorMessage: MyWrittenText.somethingWrong));
      }
    } else {
      emit(CallLogError(errorMessage: 'Permission denied'));
    }
  }
}
