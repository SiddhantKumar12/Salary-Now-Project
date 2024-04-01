part of 'employment_detail_cubit.dart';

@immutable
abstract class EmploymentDetailState {}

class EmploymentDetailInitial extends EmploymentDetailState {}

class EmploymentDetailLoading extends EmploymentDetailState {}

class EmploymentDetailLoaded extends EmploymentDetailState {
  final EmpDetailModal empDetailModal;
  EmploymentDetailLoaded({required this.empDetailModal});
}

class EmploymentDetailError extends EmploymentDetailState {
  final String error;
  EmploymentDetailError({required this.error});
}
