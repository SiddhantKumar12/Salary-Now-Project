part of 'update_micro_status_cubit.dart';

@immutable
abstract class UpdateMicroStatusState {}

class UpdateMicroStatusInitial extends UpdateMicroStatusState {}

class UpdateMicroStatusLoading extends UpdateMicroStatusState {}

class UpdateMicroStatusLoaded extends UpdateMicroStatusState {
  final UpdateMicroStatusModal updateMicroStatusModal;
  UpdateMicroStatusLoaded({required this.updateMicroStatusModal});
}

class UpdateMicroStatusError extends UpdateMicroStatusState {
  final String error;
  UpdateMicroStatusError({required this.error});
}
