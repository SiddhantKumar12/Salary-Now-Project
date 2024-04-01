part of 'location_tracker_cubit.dart';

@immutable
abstract class LocationTrackerState {}

class LocationTrackerInitial extends LocationTrackerState {}

class LocationTrackerLoading extends LocationTrackerState {}

class LocationTrackerLoaded extends LocationTrackerState {
  final String message;
  LocationTrackerLoaded({required this.message});
}

class LocationTrackerError extends LocationTrackerState {
  final String errorMessage;
  LocationTrackerError({required this.errorMessage});
}
