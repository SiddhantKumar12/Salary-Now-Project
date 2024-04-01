part of 'micro_user_save_cubit.dart';

@immutable
abstract class MicroUserSaveState {}

class MicroUserSaveInitial extends MicroUserSaveState {}

class MicroUserSaveLoading extends MicroUserSaveState {}

class MicroUserSaveLoaded extends MicroUserSaveState {
  final ErrorModal modal;
  MicroUserSaveLoaded({required this.modal});
}

class MicroUserSaveError extends MicroUserSaveState {
  final String error;
  MicroUserSaveError({required this.error});
}
