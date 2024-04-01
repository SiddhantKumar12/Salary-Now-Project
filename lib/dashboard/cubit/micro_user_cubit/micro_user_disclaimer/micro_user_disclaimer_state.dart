part of 'micro_user_disclaimer_cubit.dart';

@immutable
abstract class MicroUserDisclaimerState {}

class MicroUserDisclaimerInitial extends MicroUserDisclaimerState {}

class MicroUserDisclaimerLoading extends MicroUserDisclaimerState {}

class MicroUserDisclaimerLoaded extends MicroUserDisclaimerState {
  final MicroUserDisclaimerModal modal;
  MicroUserDisclaimerLoaded({required this.modal});
}

class MicroUserDisclaimerError extends MicroUserDisclaimerState {
  final String error;
  MicroUserDisclaimerError({required this.error});
}
