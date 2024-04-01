import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/boarding/api/on_boarding_api.dart';
import 'package:salarynow/storage/local_storage_strings.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:uuid/uuid.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../../storage/local_storage.dart';

part 'save_common_id_state.dart';

class SaveCommonIdCubit extends Cubit<SaveCommonIdState> {
  SaveCommonIdCubit() : super(SaveCommonIdInitial());

  static SaveCommonIdCubit get(context) => BlocProvider.of(context);
  final api = OnBoardingApi(DioApi(isHeader: false).sendRequest);

  static Uuid uuid = const Uuid();
  String randomUuid = uuid.v4();

  Future postCommonID() async {
    MyStorage.writeData(MyStorageString.uuid, randomUuid);
    String? fcmToken = MyStorage.readData(MyStorageString.fcmToken);

    try {
      emit(SaveCommonIdLoading());

      var data = {"fcm_token": fcmToken ?? 'FCM Is Null', "app_id": randomUuid};
      final res = await api.postCommonID(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(SaveCommonIdLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(SaveCommonIdError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(SaveCommonIdError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(SaveCommonIdError(error: MyWrittenText.somethingWrong));
    }
  }
}
