part of 'call_logs_cubit.dart';

@immutable
abstract class CallLogsState {}

class CallLogsInitial extends CallLogsState {}

class CallLogInitial extends CallLogsState {}

class CallLogLoading extends CallLogsState {}

class CallLogLoaded extends CallLogsState {
  final String message;
  CallLogLoaded({required this.message});
}

class CallLogError extends CallLogsState {
  final String errorMessage;

  CallLogError({required this.errorMessage});
}
