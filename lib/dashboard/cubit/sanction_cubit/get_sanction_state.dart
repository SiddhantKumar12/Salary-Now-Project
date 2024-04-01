part of 'get_sanction_cubit.dart';

@immutable
abstract class SanctionState {}

class SanctionInitial extends SanctionState {}

class SanctionLoading extends SanctionState {}

class SanctionLoaded extends SanctionState {
  final SanctionModal modal;
  SanctionLoaded({required this.modal});
}

class SanctionError extends SanctionState {
  final String error;
  SanctionError({required this.error});
}
