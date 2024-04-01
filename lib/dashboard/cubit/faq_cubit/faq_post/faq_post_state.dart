part of 'faq_post_cubit.dart';

@immutable
abstract class FaqPostState {}

class FaqPostInitial extends FaqPostState {}

class FaqPostLoading extends FaqPostState {}

class FaqPostLoaded extends FaqPostState {
  final ErrorModal modal;
  FaqPostLoaded({required this.modal});
}

class FaqPostError extends FaqPostState {
  final String error;
  FaqPostError({required this.error});
}
