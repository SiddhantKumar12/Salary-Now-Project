import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';

import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../utils/written_text.dart';
import '../../network/api/profile_api.dart';

part 'cancel_mandate_state.dart';

class CancelMandateCubit extends Cubit<CancelMandateState> {
  CancelMandateCubit() : super(CancelMandateInitial());

  static CancelMandateCubit get(context) => BlocProvider.of(context);

  final api = ProfileApi(DioApi(isHeader: true).sendRequest);

  Future postCancelMandate({required String remarks, required String loanNo}) async {
    try {
      emit(CancelMandateLoading());
      var data = {
        "remarks": remarks,
        "loanNo": loanNo,
      };
      final res = await api.postCancelMandate(data);

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(CancelMandateLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(CancelMandateError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(CancelMandateError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(CancelMandateError(error: MyWrittenText.somethingWrong));
    }
  }
}
