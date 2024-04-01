import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/dashboard_api.dart';
part 'delete_callback_state.dart';

class DeleteCallbackCubit extends Cubit<DeleteCallbackState> {
  DeleteCallbackCubit() : super(DeleteCallbackInitial());

  static DeleteCallbackCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getDeleteReq() async {
    try {
      emit(DeleteCallbackLoading());
      final res = await api.getDeleteReqCallback();

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(DeleteCallbackLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(DeleteCallbackError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(DeleteCallbackError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(DeleteCallbackError(error: MyWrittenText.somethingWrong));
    }
  }
}
