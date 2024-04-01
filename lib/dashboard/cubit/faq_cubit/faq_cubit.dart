import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/network/modal/faq_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/dashboard_api.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial()) {
    getFaq();
  }

  static FaqCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: false).sendRequest);

  Future getFaq() async {
    try {
      emit(FaqLoading());
      final res = await api.getFAQ();

      if (res.response.statusCode == 200) {
        FAQModal model = FAQModal.fromJson(res.data);
        emit(FaqLoaded(faqModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(FaqError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(FaqError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(FaqError(error: MyWrittenText.somethingWrong));
    }
  }
}
