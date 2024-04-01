import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../network/api/dashboard_api.dart';

part 'req_callback_state.dart';

class ReqCallbackCubit extends Cubit<ReqCallbackState> {
  ReqCallbackCubit() : super(ReqCallbackInitial());

  static ReqCallbackCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getReqCallback() async {
    try {
      emit(ReqCallbackLoading());
      final res = await api.getReqCallback();

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(ReqCallbackLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(ReqCallbackError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(ReqCallbackError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(ReqCallbackError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getReqCallback();
    return super.close();
  }
}
