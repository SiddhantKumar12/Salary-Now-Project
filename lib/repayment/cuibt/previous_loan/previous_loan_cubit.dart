import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/repayment/network/modal/previous_loan_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../service_helper/modal/error_modal.dart';
import '../../network/api/repayment_api.dart';

part 'previous_loan_state.dart';

class PreviousLoanCubit extends Cubit<PreviousLoanState> {
  PreviousLoanCubit() : super(PreviousLoanInitial()) {
    getPreviousLoan();
  }

  static PreviousLoanCubit get(context) => BlocProvider.of(context);

  final api = RepaymentApi(DioApi(isHeader: true).sendRequest);

  Future getPreviousLoan() async {
    try {
      emit(PreviousLoanLoading());
      final res = await api.getPreviousLoan();

      if (res.response.statusCode == 200) {
        PreviousLoanModal model = PreviousLoanModal.fromJson(res.data);
        emit(PreviousLoanLoaded(previousLoanModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(PreviousLoanError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(PreviousLoanError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(PreviousLoanError(error: MyWrittenText.somethingWrong));
    }
  }

  @override
  Future<void> close() {
    getPreviousLoan();
    return super.close();
  }
}
