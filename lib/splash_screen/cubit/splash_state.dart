part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashLoadedState extends SplashState {
  final bool isLoggedIn;
  final bool isUserOnBoard;
  final AppStatusModal appStatusModal;
  SplashLoadedState({required this.isLoggedIn, required this.isUserOnBoard, required this.appStatusModal});
}

class SplashErrorState extends SplashState {
  final String error;
  SplashErrorState({required this.error});
}
