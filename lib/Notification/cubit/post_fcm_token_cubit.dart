import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/Notification/network/api/fcm_api.dart';
import 'package:salarynow/utils/written_text.dart';

import '../../service_helper/api/dio_api.dart';
import '../../service_helper/error_helper.dart';
import '../../service_helper/modal/error_modal.dart';

part 'post_fcm_token_state.dart';

class PostFcmTokenCubit extends Cubit<PostFcmTokenState> {
  PostFcmTokenCubit() : super(PostFcmTokenInitial());

  static PostFcmTokenCubit get(context) => BlocProvider.of(context);

  final api = FcmApi(DioApi(isHeader: true).sendRequest);

  Future postFcm(String fcmToken) async {
    try {
      emit(PostFcmTokenLoading());

      var data = {"fcm_token": fcmToken};
      final res = await api.postFcmToken(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(PostFcmTokenLoaded(errorModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PostFcmTokenError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PostFcmTokenError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(PostFcmTokenError(error: MyWrittenText.somethingWrong));
    }
  }
}
