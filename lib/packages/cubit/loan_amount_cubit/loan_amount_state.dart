part of 'loan_amount_cubit.dart';

@immutable
abstract class LoanCalculatorState {}

class LoanCalculatorInitial extends LoanCalculatorState {}

class LoanCalculatorLoading extends LoanCalculatorState {}

class LoanCalculatorLoaded extends LoanCalculatorState {
  final LoanCalculatorModal modal;
  LoanCalculatorLoaded({required this.modal});
}

class LoanCalculatorError extends LoanCalculatorState {
  final String error;
  LoanCalculatorError({required this.error});
}
