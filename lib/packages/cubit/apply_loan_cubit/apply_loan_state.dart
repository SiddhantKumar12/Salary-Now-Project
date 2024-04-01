part of 'apply_loan_cubit.dart';

@immutable
abstract class ApplyLoanState {}

class ApplyLoanInitial extends ApplyLoanState {}

class ApplyLoanLoading extends ApplyLoanState {}

class ApplyLoanLoaded extends ApplyLoanState {
  final ApplyLoanModal applyLoanModal;
  ApplyLoanLoaded({required this.applyLoanModal});
}

class ApplyLoanError extends ApplyLoanState {
  final ErrorModal error;
  ApplyLoanError({required this.error});
}
