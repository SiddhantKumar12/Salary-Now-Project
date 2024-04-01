part of 'get_selfie_cubit.dart';

@immutable
abstract class GetSelfieState {}

class GetSelfieInitial extends GetSelfieState {}

class GetSelfieLoading extends GetSelfieState {}

class GetSelfieLoaded extends GetSelfieState {
  final SelfieModal modal;
  GetSelfieLoaded({required this.modal});
}

class GetSelfieError extends GetSelfieState {
  final String error;
  GetSelfieError({required this.error});
}
