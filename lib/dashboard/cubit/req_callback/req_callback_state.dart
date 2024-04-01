part of 'req_callback_cubit.dart';

@immutable
abstract class ReqCallbackState {}

class ReqCallbackInitial extends ReqCallbackState {}

class ReqCallbackLoading extends ReqCallbackState {}

class ReqCallbackLoaded extends ReqCallbackState {
  final ErrorModal modal;
  ReqCallbackLoaded({required this.modal});
}

class ReqCallbackError extends ReqCallbackState {
  final String error;
  ReqCallbackError({required this.error});
}
