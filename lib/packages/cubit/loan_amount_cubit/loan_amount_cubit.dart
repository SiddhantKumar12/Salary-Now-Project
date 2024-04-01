import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/packages/network/modal/loan_calculator_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/packages_api.dart';

part 'loan_amount_state.dart';

class LoanCalculatorCubit extends Cubit<LoanCalculatorState> {
  LoanCalculatorCubit() : super(LoanCalculatorInitial());

  static LoanCalculatorCubit get(context) => BlocProvider.of(context);

  final api = PackagesApi(DioApi(isHeader: true).sendRequest);

  Future postLoanAmount({
    String? productId,
    String? loanAmount,
  }) async {
    try {
      emit(LoanCalculatorLoading());

      var data = {"product_id": productId, "loan_amount": loanAmount};

      final res = await api.postLoanCalculator(data);

      if (res.response.statusCode == 200) {
        LoanCalculatorModal model = LoanCalculatorModal.fromJson(res.data);
        emit(LoanCalculatorLoaded(modal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LoanCalculatorError(
          error: errorModal.responseMsg.toString(),
        ));
      }
    } on DioError catch (e) {
      emit(LoanCalculatorError(
        error: handleDioError(e).toString(),
      ));
    } catch (e) {
      emit(LoanCalculatorError(
        error: MyWrittenText.somethingWrong,
      ));
    }
  }
}
