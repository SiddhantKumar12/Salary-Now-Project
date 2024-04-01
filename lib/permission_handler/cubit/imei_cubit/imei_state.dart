part of 'imei_cubit.dart';

@immutable
abstract class ImeiState {}

class ImeiInitial extends ImeiState {}

class ImeiNumberLoading extends ImeiState {}

class ImeiNumberLoaded extends ImeiState {
  final String imeiNumber;
  ImeiNumberLoaded({required this.imeiNumber});
}

class ImeiNumberError extends ImeiState {
  final String error;
  ImeiNumberError({required this.error});
}
