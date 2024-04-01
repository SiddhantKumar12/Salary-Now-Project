part of 'post_fcm_token_cubit.dart';

@immutable
abstract class PostFcmTokenState {}

class PostFcmTokenInitial extends PostFcmTokenState {}

class PostFcmTokenLoading extends PostFcmTokenState {}

class PostFcmTokenLoaded extends PostFcmTokenState {
  final ErrorModal errorModal;
  PostFcmTokenLoaded({required this.errorModal});
}

class PostFcmTokenError extends PostFcmTokenState {
  final String error;
  PostFcmTokenError({required this.error});
}
