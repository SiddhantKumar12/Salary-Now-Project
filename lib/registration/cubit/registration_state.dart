part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoadingState extends RegistrationState {}

class RegistrationLoadedState extends RegistrationState {
  final RegistrationModal registrationModal;
  RegistrationLoadedState(this.registrationModal);
}

class RegistrationErrorState extends RegistrationState {
  final String error;
  RegistrationErrorState(this.error);
}

class DatePickerState extends RegistrationState {
  final String selectedDate;
  DatePickerState({required this.selectedDate});
}

class DateErrorState extends RegistrationState {
  final String? error;
  DateErrorState({required this.error});
}

class PinCodeInitial extends RegistrationState {}

class PinCodeLoadingState extends RegistrationState {}

class PinCodeLoadedState extends RegistrationState {
  final PinCodeModal pinCodeModal;
  PinCodeLoadedState(this.pinCodeModal);
}

class PinCodeErrorState extends RegistrationState {
  final String error;
  PinCodeErrorState(this.error);
}

class EmpTypeInitialState extends RegistrationState {}

class EmpLoadingState extends RegistrationState {}

class EmpTypeLoadedState extends RegistrationState {
  final EmploymentTypeModal employmentTypeModal;
  EmpTypeLoadedState(this.employmentTypeModal);
}

class EmpTypeErrorState extends RegistrationState {
  final String error;
  EmpTypeErrorState(this.error);
}

/// State
class StateLoadingState extends RegistrationState {}

class StateLoadedState extends RegistrationState {
  final StateModal stateModal;
  StateLoadedState(this.stateModal);
}

class StateErrorState extends RegistrationState {
  final String error;
  StateErrorState({required this.error});
}

/// City
class CityLoadingState extends RegistrationState {}

class CityLoadedState extends RegistrationState {
  final CityModal cityModal;
  CityLoadedState(this.cityModal);
}

class CityErrorState extends RegistrationState {
  final String error;
  CityErrorState({required this.error});
}
