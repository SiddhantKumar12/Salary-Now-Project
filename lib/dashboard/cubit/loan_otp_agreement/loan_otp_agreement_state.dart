part of 'loan_otp_agreement_cubit.dart';

@immutable
abstract class LoanAgreementOTPState {}

class LoanAgreementOTPInitial extends LoanAgreementOTPState {}

class LoanAgreementLoading extends LoanAgreementOTPState {}

class LoanAgreementOTPLoaded extends LoanAgreementOTPState {
  final ErrorModal errorModal;
  LoanAgreementOTPLoaded({
    required this.errorModal,
  });
}

class LoanAgreementOTPError extends LoanAgreementOTPState {
  final String error;
  LoanAgreementOTPError({required this.error});
}
