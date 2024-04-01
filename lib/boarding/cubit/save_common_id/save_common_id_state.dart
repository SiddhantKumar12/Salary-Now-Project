part of 'save_common_id_cubit.dart';

@immutable
abstract class SaveCommonIdState {}

class SaveCommonIdInitial extends SaveCommonIdState {}

class SaveCommonIdLoading extends SaveCommonIdState {}

class SaveCommonIdLoaded extends SaveCommonIdState {
  final ErrorModal modal;
  SaveCommonIdLoaded({required this.modal});
}

class SaveCommonIdError extends SaveCommonIdState {
  final String error;
  SaveCommonIdError({required this.error});
}
