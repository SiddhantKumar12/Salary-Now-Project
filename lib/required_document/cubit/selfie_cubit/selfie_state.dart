part of 'selfie_cubit.dart';

@immutable
abstract class SelfieState {}

class SelfieInitial extends SelfieState {}

class SelfieLoadingState extends SelfieState {}

class SelfieLoadedState extends SelfieState {
  final File file;
  final Position position;
  final String place;
  SelfieLoadedState({required this.file, required this.position, required this.place});
}

class SelfieErrorState extends SelfieState {
  final String error;
  SelfieErrorState({required this.error});
}

class GetSelfieLoadingState extends SelfieState {}

class GetSelfieLoadedState extends SelfieState {
  final String imageUrl;
  GetSelfieLoadedState({required this.imageUrl});
}

class GetSelfieErrorState extends SelfieState {
  final String error;
  GetSelfieErrorState({required this.error});
}
