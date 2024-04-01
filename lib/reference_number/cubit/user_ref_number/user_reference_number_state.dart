part of 'user_reference_number_cubit.dart';

@immutable
abstract class UserReferenceNumberState {}

class UserReferenceNumberInitial extends UserReferenceNumberState {}

class UserReferenceNumberLoading extends UserReferenceNumberState {}

class UserReferenceNumberLoaded extends UserReferenceNumberState {
  final List<MyCallLogModal> callLog;
  UserReferenceNumberLoaded({
    required this.callLog,
  });
}

class UserReferenceNumberError extends UserReferenceNumberState {
  final String errorMessage;
  UserReferenceNumberError({required this.errorMessage});
}
