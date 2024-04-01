import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../network/api/dashboard_api.dart';

part 'loan_verify_otp_agree_state.dart';

class LoanVerifyOtpAgreeCubit extends Cubit<LoanVerifyOtpAgreeState> {
  LoanVerifyOtpAgreeCubit() : super(LoanVerifyOtpAgreeInitial());

  static LoanVerifyOtpAgreeCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future verifyOtpLoan({required String mobileNumber, required String otp}) async {
    try {
      emit(LoanVerifyOtpAgreeLoading());
      final res = await api.loanOtpVerify({'mobile': mobileNumber, 'otp': otp});

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(LoanVerifyOtpAgreeLoaded(modal: model));
      } else if (res.response.statusCode == 400) {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LoanVerifyOtpAgreeError(errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(LoanVerifyOtpAgreeError(handleDioError(e).toString()));
    } catch (e) {
      emit(LoanVerifyOtpAgreeError(MyWrittenText.somethingWrong));
    }
  }
}
