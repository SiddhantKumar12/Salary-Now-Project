part of 'document_cubit.dart';

@immutable
abstract class DocumentState {}

class DocumentInitial extends DocumentState {}

/// Doc Address Type
class DocAddTypeLoading extends DocumentState {}

class DocAddTypeLoaded extends DocumentState {
  final DocAddressTypeModal docAddressTypeModal;
  DocAddTypeLoaded({required this.docAddressTypeModal});
}

class DocAddTypeError extends DocumentState {
  final String error;
  DocAddTypeError({required this.error});
}

/// Doc Accomodation Type
class DocAccomodationLoading extends DocumentState {}

class DocAccomodationLoaded extends DocumentState {
  final DocAccomodationModal docAccomodationModal;
  DocAccomodationLoaded({required this.docAccomodationModal});
}

class DocAccomodationError extends DocumentState {
  final String error;
  DocAccomodationError({required this.error});
}
