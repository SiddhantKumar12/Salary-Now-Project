part of 'app_version_cubit.dart';

@immutable
abstract class AppVersionState {}

class AppVersionInitial extends AppVersionState {}

class AppVersionLoading extends AppVersionState {}

class AppVersionLoaded extends AppVersionState {
  final AppVersionModal appVersionModal;
  final String appVersion;
  AppVersionLoaded({required this.appVersionModal, required this.appVersion});
}

class AppVersionError extends AppVersionState {
  final String error;
  AppVersionError({required this.error});
}
