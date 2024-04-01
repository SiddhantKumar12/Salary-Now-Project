part of 'loan_emp_cubit.dart';

@immutable
abstract class LoanEmpState {}

class LoanEmpInitial extends LoanEmpState {}

class LoanEmpLoading extends LoanEmpState {}

class LoanEmpLoaded extends LoanEmpState {
  final EmpDetailModal empDetailModal;
  LoanEmpLoaded({required this.empDetailModal});
}

class LoanEmpError extends LoanEmpState {
  final String error;
  LoanEmpError({required this.error});
}
