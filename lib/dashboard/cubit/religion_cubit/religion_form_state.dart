part of 'religion_form_cubit.dart';

@immutable
abstract class ReligionFormState {}

class ReligionFormInitial extends ReligionFormState {}

class ReligionFormLoading extends ReligionFormState {}

class ReligionFormLoaded extends ReligionFormState {
  final ReligionFormModal modal;
  ReligionFormLoaded({required this.modal});
}

class ReligionFormError extends ReligionFormState {
  final String error;
  ReligionFormError({required this.error});
}
