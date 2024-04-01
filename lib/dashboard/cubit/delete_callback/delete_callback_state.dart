part of 'delete_callback_cubit.dart';

@immutable
abstract class DeleteCallbackState {}

class DeleteCallbackInitial extends DeleteCallbackState {}

class DeleteCallbackLoading extends DeleteCallbackState {}

class DeleteCallbackLoaded extends DeleteCallbackState {
  final ErrorModal modal;
  DeleteCallbackLoaded({required this.modal});
}

class DeleteCallbackError extends DeleteCallbackState {
  final String error;
  DeleteCallbackError({required this.error});
}
