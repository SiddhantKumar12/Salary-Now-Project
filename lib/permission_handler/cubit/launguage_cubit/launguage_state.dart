part of 'launguage_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final ErrorModal modal;
  LanguageLoaded({required this.modal});
}

class LanguageError extends LanguageState {
  final String error;
  LanguageError({required this.error});
}
