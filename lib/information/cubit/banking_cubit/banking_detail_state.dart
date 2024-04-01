part of 'banking_detail_cubit.dart';

@immutable
abstract class BankingDetailState {}

class BankingDetailInitial extends BankingDetailState {}

class BankingDetailLoading extends BankingDetailState {}

class BankingDetailLoaded extends BankingDetailState {
  final BankDetailsModal bankingDetailsModal;
  BankingDetailLoaded({required this.bankingDetailsModal});
}

class BankingDetailError extends BankingDetailState {
  final String error;
  BankingDetailError({required this.error});
}
