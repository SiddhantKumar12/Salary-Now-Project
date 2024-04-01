part of 'get_document_cubit.dart';

@immutable
abstract class GetDocumentState {}

class GetDocumentInitial extends GetDocumentState {}

/// Get Document
class GetDocumentLoading extends GetDocumentState {}

class GetDocumentLoaded extends GetDocumentState {
  final DocumentGetModal modal;
  GetDocumentLoaded({required this.modal});
}

class SalarySlipLoaded extends GetDocumentState {
  final SalarySlipModal modal;
  SalarySlipLoaded({required this.modal});
}

class AddressProofLoaded extends GetDocumentState {
  final AddressProofModal modal;
  AddressProofLoaded({required this.modal});
}

class AccommodationReqLoaded extends GetDocumentState {
  final AccomodationReqModal modal;
  AccommodationReqLoaded({required this.modal});
}

class BankStatementLoaded extends GetDocumentState {
  final BankStatementModal modal;
  BankStatementLoaded({required this.modal});
}

class GetDocumentError extends GetDocumentState {
  final String error;
  GetDocumentError({required this.error});
}
