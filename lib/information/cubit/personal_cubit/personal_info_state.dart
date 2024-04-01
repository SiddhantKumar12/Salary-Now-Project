part of 'personal_info_cubit.dart';

@immutable
abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoLoaded extends PersonalInfoState {
  final PersonalDetailsModal personalDetailsModal;
  PersonalInfoLoaded({required this.personalDetailsModal});
}

class PersonalInfoError extends PersonalInfoState {
  final String error;
  PersonalInfoError({required this.error});
}
