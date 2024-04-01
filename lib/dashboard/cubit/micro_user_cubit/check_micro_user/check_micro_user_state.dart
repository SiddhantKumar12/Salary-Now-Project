part of 'check_micro_user_cubit.dart';

@immutable
abstract class CheckMicroUserState {}

class CheckMicroUserInitial extends CheckMicroUserState {}

class CheckMicroUserLoading extends CheckMicroUserState {}

class CheckMicroUserLoaded extends CheckMicroUserState {
  final CheckMicroUserModal checkMicroUserModal;
  CheckMicroUserLoaded({required this.checkMicroUserModal});
}

class CheckMicroUserError extends CheckMicroUserState {
  final String error;
  CheckMicroUserError({required this.error});
}
