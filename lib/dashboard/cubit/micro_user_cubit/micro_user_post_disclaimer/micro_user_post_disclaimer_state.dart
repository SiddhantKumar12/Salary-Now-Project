part of 'micro_user_post_disclaimer_cubit.dart';

@immutable
abstract class MicroUserPostDisclaimerState {}

class MicroUserPostDisclaimerInitial extends MicroUserPostDisclaimerState {}

class MicroUserPostDisclaimerLoading extends MicroUserPostDisclaimerState {}

class MicroUserPostDisclaimerLoaded extends MicroUserPostDisclaimerState {
  final MicroUserPostDisclaimerModal modal;
  MicroUserPostDisclaimerLoaded({required this.modal});
}

class MicroUserPostDisclaimerError extends MicroUserPostDisclaimerState {
  final String error;
  MicroUserPostDisclaimerError({required this.error});
}
