part of 'req_document_cubit.dart';

@immutable
abstract class ReqDocumentState {}

class ReqDocumentInitial extends ReqDocumentState {}

/// Req Document
class ReqDocumentLoading extends ReqDocumentState {}

class ReqDocumentLoaded extends ReqDocumentState {
  final ReqDocumentModal modal;
  ReqDocumentLoaded({required this.modal});
}

class ReqDocumentError extends ReqDocumentState {
  final String error;
  ReqDocumentError({required this.error});
}
