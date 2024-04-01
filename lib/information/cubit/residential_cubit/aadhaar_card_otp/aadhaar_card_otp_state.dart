part of 'aadhaar_card_otp_cubit.dart';

@immutable
abstract class AadhaarCardOtpState {}

class AadhaarCardOtpInitial extends AadhaarCardOtpState {}

class AadhaarCardOtpLoading extends AadhaarCardOtpState {}

class AadhaarCardOtpLoaded extends AadhaarCardOtpState {
  final AadhaarOtpModal aadhaarOtpModal;
  AadhaarCardOtpLoaded({required this.aadhaarOtpModal});
}

class AadhaarCardOtpError extends AadhaarCardOtpState {
  final AadhaarOtpErrorModal? aadhaarOtpErrorModal;
  final String error;
  final bool isAadhaarWorking;
  AadhaarCardOtpError({
    required this.error,
    this.aadhaarOtpErrorModal,
    required this.isAadhaarWorking,
  });
}
