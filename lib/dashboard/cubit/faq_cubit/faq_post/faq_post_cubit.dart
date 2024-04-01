import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../network/api/dashboard_api.dart';

part 'faq_post_state.dart';

class FaqPostCubit extends Cubit<FaqPostState> {
  FaqPostCubit() : super(FaqPostInitial());

  static FaqPostCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future postFaq({required String type, required String question}) async {
    try {
      emit(FaqPostLoading());
      var data = {"type": "YES", "question": "What's Salary Now?"};
      final res = await api.postFAQ(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(FaqPostLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(FaqPostError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(FaqPostError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(FaqPostError(error: MyWrittenText.somethingWrong));
    }
  }
}
