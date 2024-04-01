part of 'security_cubit.dart';

@immutable
abstract class SecurityState {}

class SecurityInitial extends SecurityState {}

class SecurityDialogState extends SecurityState {
  final bool isDebugging;
  // final bool isRealDevice;
  SecurityDialogState({
    // required this.isRealDevice,
    required this.isDebugging,
  });
}

class SecurityNoDialogState extends SecurityState {}
