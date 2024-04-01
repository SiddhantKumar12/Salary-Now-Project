import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:salarynow/dashboard/network/api/dashboard_api.dart';
import 'package:salarynow/service_helper/modal/error_modal.dart';
import '../../../service_helper/api/dio_api.dart';
import '../../../service_helper/error_helper.dart';
import '../../../utils/written_text.dart';

part 'loan_otp_agreement_state.dart';

class LoanAgreementOTPCubit extends Cubit<LoanAgreementOTPState> {
  LoanAgreementOTPCubit() : super(LoanAgreementOTPInitial());

  static LoanAgreementOTPCubit get(context) => BlocProvider.of(context);
  final api = DashboardAPi(DioApi(isHeader: true).sendRequest);

  Future getLoanAgreeOtp() async {
    try {
      emit(LoanAgreementLoading());
      final res = await api.getLoanAgreeOtp();

      if (res.response.statusCode == 200) {
        ErrorModal model = ErrorModal.fromJson(res.data);
        emit(LoanAgreementOTPLoaded(errorModal: model));
      } else {
        ErrorModal errorModal = ErrorModal.fromJson(res.data);
        emit(LoanAgreementOTPError(error: errorModal.responseMsg.toString()));
      }
    } on DioError catch (e) {
      emit(LoanAgreementOTPError(error: handleDioError(e).toString()));
    } catch (e) {
      emit(LoanAgreementOTPError(error: MyWrittenText.somethingWrong));
    }
  }
}
