part of 'bank_list_cubit.dart';

@immutable
abstract class BankListState {}

class BankListInitial extends BankListState {}

/// BankList
class BankListLoadingState extends BankListState {}

class BankListLoadedState extends BankListState {
  final BankListModal bankListModal;
  BankListLoadedState(this.bankListModal);
}

class BankListErrorState extends BankListState {
  final String error;
  BankListErrorState({required this.error});
}
