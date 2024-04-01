part of 'sms_cubit.dart';

@immutable
abstract class SmsState {}

class SmsInitial extends SmsState {}

class SmsLoadingState extends SmsState {}

class SmsLoadedState extends SmsState {
  final String message;
  SmsLoadedState({required this.message});
}

class SmsErrorState extends SmsState {
  final String errorMessage;
  SmsErrorState({required this.errorMessage});
}
