import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/repayment/network/api/repayment_api.dart';
import 'package:salarynow/repayment/network/modal/loan_charges_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';

part 'repayment_state.dart';

class RepaymentCubit extends Cubit<RepaymentState> {
  RepaymentCubit() : super(RepaymentInitial());

  static RepaymentCubit get(context) => BlocProvider.of(context);

  final api = RepaymentApi(DioApi(isHeader: true).sendRequest);
  Future getRepayment() async {
    try {
      emit(RepaymentLoadingState());
      final res = await api.getLoanCharges();

      if (res.response.statusCode == 200) {
        LoanChargesModal model = LoanChargesModal.fromJson(res.data);
        emit(RepaymentLoadedState(loanChargesModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(RepaymentErrorState(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(RepaymentErrorState(error: handleDioError(e).toString()));
    }
    // catch (e) {
    //   emit(RepaymentErrorState(error: MyWrittenText.somethingWrong));
    // }
  }

  @override
  Future<void> close() {
    getRepayment();
    return super.close();
  }
}
