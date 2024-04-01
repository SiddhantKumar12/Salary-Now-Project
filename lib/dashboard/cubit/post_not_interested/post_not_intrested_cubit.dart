import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../network/api/dashboard_api.dart';
part 'post_not_intrested_state.dart';

class PostNotInterestedCubit extends Cubit<PostNotIntrestedState> {
  PostNotInterestedCubit() : super(PostNotIntrestedInitial());

  static PostNotInterestedCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future postReason({required String remarks, required String loanId, required String reason}) async {
    try {
      emit(PostNotIntrestedLoading());

      var data = {
        "remarks": remarks,
        "loan_id": loanId,
        "reason": reason,
      };
      final res = await api.postNotInterested(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(PostNotIntrestedLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PostNotIntrestedError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PostNotIntrestedError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(PostNotIntrestedError(error: MyWrittenText.somethingWrong));
    }
  }
}
