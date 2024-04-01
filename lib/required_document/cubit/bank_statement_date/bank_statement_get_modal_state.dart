part of 'bank_statement_get_modal_cubit.dart';

@immutable
abstract class BankStatementGetState {}

class BankStatementGetInitial extends BankStatementGetState {}

class BankStatementGetLoading extends BankStatementGetState {}

class BankStatementGetLoaded extends BankStatementGetState {
  final BankStatementDateModal bankStatementModal;
  BankStatementGetLoaded({required this.bankStatementModal});
}

class BankStatementGetError extends BankStatementGetState {
  final String error;
  BankStatementGetError({required this.error});
}
