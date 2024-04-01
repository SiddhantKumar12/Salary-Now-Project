import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../../service_helper/api/dio_api.dart';
import '../../../../service_helper/error_helper.dart';
import '../../../../service_helper/modal/error_modal.dart';
import '../../network/api/packages_api.dart';
import '../../network/modal/loan_calculator_modal.dart';

part 'loan_slider_state.dart';

class LoanSliderCubit extends Cubit<LoanSliderState> {
  LoanSliderCubit() : super(LoanSliderInitial());

  static LoanSliderCubit get(context) => BlocProvider.of(context);

  final api = PackagesApi(DioApi(isHeader: true).sendRequest);

  Future postLoanAmount({
    String? productId,
    String? loanAmount,
    required bool isLoanSubmitScreen,
  }) async {
    try {
      if (!isLoanSubmitScreen) {
        emit(LoanSliderLoading());
      } else {
        emit(LoanSlider2Loading());
      }

      var data = {"product_id": productId, "loan_amount": loanAmount};

      final res = await api.postLoanCalculator(data);

      if (res.response.statusCode == 200) {
        LoanCalculatorModal model = LoanCalculatorModal.fromJson(res.data);
        emit(LoanSliderLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LoanSliderError(
          error: errorModal.responseMsg.toString(),
        ));
      }
    } on DioError catch (e) {
      if (!isLoanSubmitScreen) {
        emit(LoanSliderError(
          error: handleDioError(e).toString(),
        ));
      } else {
        emit(LoanSlider2Error(
          error: handleDioError(e).toString(),
        ));
      }
    } catch (e) {
      if (!isLoanSubmitScreen) {
        emit(LoanSliderError(
          error: MyWrittenText.somethingWrong,
        ));
      } else {
        emit(LoanSlider2Error(
          error: MyWrittenText.somethingWrong,
        ));
      }
    }
  }
}
