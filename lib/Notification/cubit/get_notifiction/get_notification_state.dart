part of 'get_notification_cubit.dart';

@immutable
abstract class GetNotificationState {}

class GetNotificationInitial extends GetNotificationState {}

class GetNotificationLoading extends GetNotificationState {}

class GetNotificationLoaded extends GetNotificationState {
  final NotificationGetModal notificationGetModal;
  GetNotificationLoaded({required this.notificationGetModal});
}

class GetNotificationError extends GetNotificationState {
  final String error;
  GetNotificationError({required this.error});
}
