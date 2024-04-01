part of 'update_info_cubit.dart';

@immutable
abstract class UpdateInfoState {}

class UpdateInfoInitial extends UpdateInfoState {}

class UpdatePersonalInfoLoading extends UpdateInfoState {}

class UpdatePersonalInfoLoaded extends UpdateInfoState {
  final PersonalDetailsModal personalDetailsModal;
  UpdatePersonalInfoLoaded({required this.personalDetailsModal});
}

class UpdatePersonalInfoError extends UpdateInfoState {
  final String error;
  UpdatePersonalInfoError({required this.error});
}

class UpdateEmpDetailLoading extends UpdateInfoState {}

class UpdateEmpDetailLoaded extends UpdateInfoState {
  final EmpDetailModal empDetailModal;
  UpdateEmpDetailLoaded({required this.empDetailModal});
}

class UpdateEmpDetailError extends UpdateInfoState {
  final String error;
  UpdateEmpDetailError({required this.error});
}

class UpdateResiDetailLoading extends UpdateInfoState {}

class UpdateResiDetailLoaded extends UpdateInfoState {
  final ResidentialDetailsModal residentialDetailsModal;
  UpdateResiDetailLoaded({required this.residentialDetailsModal});
}

class UpdateResiDetailError extends UpdateInfoState {
  final String error;
  UpdateResiDetailError({required this.error});
}

class UpdateBankDetailLoading extends UpdateInfoState {}

class UpdateBankDetailLoaded extends UpdateInfoState {
  final BankDetailsModal bankDetailsModal;
  UpdateBankDetailLoaded({required this.bankDetailsModal});
}

class UpdateBankDetailError extends UpdateInfoState {
  final String error;
  UpdateBankDetailError({required this.error});
}
