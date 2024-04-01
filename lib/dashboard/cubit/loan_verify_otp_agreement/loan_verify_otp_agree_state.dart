part of 'loan_verify_otp_agree_cubit.dart';

@immutable
abstract class LoanVerifyOtpAgreeState {}

class LoanVerifyOtpAgreeInitial extends LoanVerifyOtpAgreeState {}

class LoanVerifyOtpAgreeLoading extends LoanVerifyOtpAgreeState {}

class LoanVerifyOtpAgreeLoaded extends LoanVerifyOtpAgreeState {
  final ErrorModal modal;
  LoanVerifyOtpAgreeLoaded({required this.modal});
}

class LoanVerifyOtpAgreeError extends LoanVerifyOtpAgreeState {
  final String error;
  LoanVerifyOtpAgreeError(this.error);
}
