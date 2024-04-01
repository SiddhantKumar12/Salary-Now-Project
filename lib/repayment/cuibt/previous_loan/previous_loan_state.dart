part of 'previous_loan_cubit.dart';

@immutable
abstract class PreviousLoanState {}

class PreviousLoanInitial extends PreviousLoanState {}

class PreviousLoanLoading extends PreviousLoanState {}

class PreviousLoanLoaded extends PreviousLoanState {
  final PreviousLoanModal previousLoanModal;
  PreviousLoanLoaded({required this.previousLoanModal});
}

class PreviousLoanError extends PreviousLoanState {
  final String error;
  PreviousLoanError({required this.error});
}
