part of 'pan_card_validation_cubit.dart';

@immutable
abstract class PanCardValidationState {}

class PanCardValidationInitial extends PanCardValidationState {}

class PanCardValidationLoading extends PanCardValidationState {}

class PanCardValidationLoaded extends PanCardValidationState {
  final PanCardModal panCardModal;
  PanCardValidationLoaded({required this.panCardModal});
}

class PanCardValidationError extends PanCardValidationState {
  final String error;
  PanCardValidationError({required this.error});
}
