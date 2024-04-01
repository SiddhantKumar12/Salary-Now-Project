part of 'cancel_mandate_cubit.dart';

@immutable
abstract class CancelMandateState {}

class CancelMandateInitial extends CancelMandateState {}

class CancelMandateLoading extends CancelMandateState {}

class CancelMandateLoaded extends CancelMandateState {
  final ErrorModal modal;
  CancelMandateLoaded({required this.modal});
}

class CancelMandateError extends CancelMandateState {
  final String error;
  CancelMandateError({required this.error});
}
