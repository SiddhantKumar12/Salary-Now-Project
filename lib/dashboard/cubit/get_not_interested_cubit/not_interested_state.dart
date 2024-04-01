part of 'not_interested_cubit.dart';

@immutable
abstract class NotInterestedState {}

class NotInterestedInitial extends NotInterestedState {}

class NotInterestedLoading extends NotInterestedState {}

class NotInterestedLoaded extends NotInterestedState {
  final NotInterestedModal modal;
  NotInterestedLoaded({required this.modal});
}

class NotInterestedError extends NotInterestedState {
  final String error;
  NotInterestedError({required this.error});
}
