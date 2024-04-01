part of 'repayment_cubit.dart';

@immutable
abstract class RepaymentState {}

class RepaymentInitial extends RepaymentState {}

class RepaymentLoadingState extends RepaymentState {}

class RepaymentLoadedState extends RepaymentState {
  final LoanChargesModal loanChargesModal;
  RepaymentLoadedState({required this.loanChargesModal});
}

class RepaymentErrorState extends RepaymentState {
  final String error;
  RepaymentErrorState({required this.error});
}
