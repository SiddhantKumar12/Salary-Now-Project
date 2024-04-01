part of 'form_helper_cubit.dart';

@immutable
abstract class FormHelperApiState {}

class FormHelperApiInitial extends FormHelperApiState {}

/// Employment Type
class EmpLoadingState extends FormHelperApiState {}

class EmpTypeLoadedState extends FormHelperApiState {
  final EmploymentTypeModal employmentTypeModal;
  EmpTypeLoadedState(this.employmentTypeModal);
}

class EmpTypeErrorState extends FormHelperApiState {
  final String error;
  EmpTypeErrorState(this.error);
}

/// State
class StateLoadingState extends FormHelperApiState {}

class StateLoadedState extends FormHelperApiState {
  final StateModal stateModal;
  StateLoadedState(this.stateModal);
}

class StateErrorState extends FormHelperApiState {
  final String error;
  StateErrorState({required this.error});
}

/// Salary Mode
class SalaryModeLoadingState extends FormHelperApiState {}

class SalaryModeLoadedState extends FormHelperApiState {
  final SalaryModal salaryModal;
  SalaryModeLoadedState(this.salaryModal);
}

class SalaryModeErrorState extends FormHelperApiState {
  final String error;
  SalaryModeErrorState({required this.error});
}

/// User Common
class UserCommonLoadingState extends FormHelperApiState {}

class UserCommonLoadedState extends FormHelperApiState {
  final UserCommonModal userCommonModal;
  UserCommonLoadedState(this.userCommonModal);
}

class UserCommonErrorState extends FormHelperApiState {
  final String error;
  UserCommonErrorState({required this.error});
}

class UserGenderLoadedState extends FormHelperApiState {
  final List<Gender> gender;
  UserGenderLoadedState(this.gender);
}

class UserMaritalLoadedState extends FormHelperApiState {
  final List<Marital> marital;
  UserMaritalLoadedState(this.marital);
}

class UserAccomodationLoadedState extends FormHelperApiState {
  final List<Accomadation> accomadation;
  UserAccomodationLoadedState(this.accomadation);
}

class UserEducationLoadedState extends FormHelperApiState {
  final List<Qualification> qualification;
  UserEducationLoadedState(this.qualification);
}

/// City
class CityLoadingState extends FormHelperApiState {}

class CityLoadedState extends FormHelperApiState {
  final CityModal cityModal;
  CityLoadedState(this.cityModal);
}

class CityErrorState extends FormHelperApiState {
  final String error;
  CityErrorState({required this.error});
}

class SecondCityLoadingState extends FormHelperApiState {}

class SecondCityLoadedState extends FormHelperApiState {
  final CityModal cityModal;
  SecondCityLoadedState(this.cityModal);
}

class SecondCityErrorState extends FormHelperApiState {
  final String error;
  SecondCityErrorState({required this.error});
}

/// PinCode
class PinCodeeLoadingState extends FormHelperApiState {}

class PinCodeeLoadedState extends FormHelperApiState {
  final PinCodeModal pinCodeModal;
  PinCodeeLoadedState(this.pinCodeModal);
}

class PinCodeeErrorState extends FormHelperApiState {
  final String error;
  PinCodeeErrorState(this.error);
}

/// Ifsc
class IfscLoadingState extends FormHelperApiState {}

class IfscLoadedState extends FormHelperApiState {
  final IfscModal ifscModal;
  IfscLoadedState(this.ifscModal);
}

class IfscErrorState extends FormHelperApiState {
  final String error;
  IfscErrorState(this.error);
}

class DatePickerLoading extends FormHelperApiState {
  DatePickerLoading();
}

class DatePickerLoaded extends FormHelperApiState {
  final String selectedDate;
  DatePickerLoaded({required this.selectedDate});
}
