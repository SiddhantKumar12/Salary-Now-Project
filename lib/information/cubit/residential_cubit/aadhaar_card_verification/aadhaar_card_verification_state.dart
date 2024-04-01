part of 'aadhaar_card_verification_cubit.dart';

@immutable
abstract class AadhaarCardVerificationState {}

class AadhaarCardVerificationInitial extends AadhaarCardVerificationState {}

class AadhaarCardVerificationLoading extends AadhaarCardVerificationState {}

class AadhaarCardVerificationLoaded extends AadhaarCardVerificationState {
  final AadhaarCardVerifyModal aadhaarCardVerifyModal;
  AadhaarCardVerificationLoaded({required this.aadhaarCardVerifyModal});
}

class AadhaarCardVerificationError extends AadhaarCardVerificationState {
  final String error;
  AadhaarCardVerificationError({required this.error});
}
