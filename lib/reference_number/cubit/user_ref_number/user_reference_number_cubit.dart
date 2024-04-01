import 'package:call_log/call_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../permission_handler/network/call_log_modal.dart';
part 'user_reference_number_state.dart';

class UserReferenceNumberCubit extends Cubit<UserReferenceNumberState> {
  UserReferenceNumberCubit() : super(UserReferenceNumberInitial());

  static UserReferenceNumberCubit get(context) => BlocProvider.of(context);

  Future<void> fetchRefNumber() async {
    emit(UserReferenceNumberLoading());
    final List<Permission> permissions = [
      Permission.phone,
    ];

    final Map<Permission, PermissionStatus> permissionStatuses = await permissions.request();

    if (permissionStatuses[Permission.phone]!.isGranted) {
      try {
        /// call Log
        final Iterable<CallLogEntry> callLogEntries = await CallLog.query();
        List<MyCallLogModal> callLogData = [];
        for (var entry in callLogEntries) {
          if (filterCallLog(entry.number!, entry.timestamp) != null && entry.name != null && entry.name!.isNotEmpty) {
            String newNumber = entry.number!.substring(entry.number!.length - 10);
            callLogData.removeWhere((element) => element.phone == newNumber);
            callLogData.add(MyCallLogModal(
                type: entry.callType.toString(),
                date: entry.timestamp.toString(),
                duration: entry.duration.toString(),
                name: entry.name,
                phone: filterCallLog(entry.number!, entry.timestamp)));
          }
        }

        List<MyCallLogModal>? finalRefData = callLogData;

        if (finalRefData.isNotEmpty) {
          emit(UserReferenceNumberLoaded(
            callLog: finalRefData,
          ));
        } else {
          emit(UserReferenceNumberError(errorMessage: 'No contact in call Log directory'));
        }
      } catch (e) {
        emit(UserReferenceNumberError(errorMessage: 'Can\'t Load Contact'));
      }
    } else {
      emit(UserReferenceNumberError(errorMessage: 'Give Phone Permission'));
    }
  }

  String? filterCallLog(String phoneNumbers, int? timeStamp) {
    DateTime currentDate = DateTime.now();
    DateTime sevenDaysAgo = currentDate.subtract(const Duration(days: 15));
    DateTime callLogDatetime = DateTime.fromMillisecondsSinceEpoch(timeStamp!);

    if (callLogDatetime.isAfter(sevenDaysAgo)) {
      String newNumber = phoneNumbers.replaceAll(RegExp('[^0-9]'), '');
      newNumber = newNumber.replaceAll(" ", "");

      if (newNumber.length >= 10) {
        return newNumber.substring(newNumber.length - 10);
      }
    }
    return null;
  }
}
