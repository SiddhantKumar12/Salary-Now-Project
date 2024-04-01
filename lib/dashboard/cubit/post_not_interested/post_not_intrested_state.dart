part of 'post_not_intrested_cubit.dart';

@immutable
abstract class PostNotIntrestedState {}

class PostNotIntrestedInitial extends PostNotIntrestedState {}

class PostNotIntrestedLoading extends PostNotIntrestedState {}

class PostNotIntrestedLoaded extends PostNotIntrestedState {
  final ErrorModal modal;
  PostNotIntrestedLoaded({required this.modal});
}

class PostNotIntrestedError extends PostNotIntrestedState {
  final String error;
  PostNotIntrestedError({required this.error});
}
