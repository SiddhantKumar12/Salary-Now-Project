part of 'ledger_cubit.dart';

@immutable
abstract class LedgerState {}

class LedgerInitial extends LedgerState {}

class LedgerLoading extends LedgerState {}

class LedgerLoaded extends LedgerState {
  final LedgerModal ledgerModal;
  LedgerLoaded({required this.ledgerModal});
}

class LedgerError extends LedgerState {
  final String error;
  LedgerError({required this.error});
}
