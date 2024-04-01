part of 'permission_cubit.dart';

@immutable
abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

/// All Permission
class AllPermissionLoading extends PermissionState {}

class AllPermissionGranted extends PermissionState {}

class AllPermissionDenied extends PermissionState {
  final bool allowPhonePermission;
  // final bool allowContactPermission;
  final bool allowSmsPermission;
  // final bool allowStoragePermission;
  final bool allowLocationPermission;
  final bool allowCameraPermission;
  AllPermissionDenied({
    required this.allowCameraPermission,
    required this.allowPhonePermission,
    // required this.allowContactPermission,
    required this.allowSmsPermission,
    // required this.allowStoragePermission,
    required this.allowLocationPermission,
  });
}

/// Phone Permission

class PhonePermissionGranted extends PermissionState {}

class PhonePermissionDenied extends PermissionState {
  final String denied;
  PhonePermissionDenied({required this.denied});
}

/// Contact Permission

class ContactPermissionGranted extends PermissionState {
  ContactPermissionGranted();
}

class ContactPermissionDenied extends PermissionState {
  final String denied;
  ContactPermissionDenied({required this.denied});
}

/// Sms Permission

class SmsPermissionGranted extends PermissionState {}

class SmsPermissionDenied extends PermissionState {
  final String denied;
  SmsPermissionDenied({required this.denied});
}

/// Camera Permission

class CameraPermissionGranted extends PermissionState {}

class CameraPermissionDenied extends PermissionState {
  final String denied;
  CameraPermissionDenied({required this.denied});
}

/// Storage Permission

class StoragePermissionGranted extends PermissionState {}

class StoragePermissionDenied extends PermissionState {
  final String denied;
  StoragePermissionDenied({required this.denied});
}

/// Location Permission

class LocationPermissionGranted extends PermissionState {}

class LocationPermissionDenied extends PermissionState {
  final String denied;
  LocationPermissionDenied({required this.denied});
}

/// Current Location

class CurrentLocationLoading extends PermissionState {}

class CurrentLocationLoaded extends PermissionState {
  final Position position;
  final Placemark place;
  CurrentLocationLoaded({required this.position, required this.place});
}

class CurrentLocationError extends PermissionState {
  final String error;
  CurrentLocationError({required this.error});
}
