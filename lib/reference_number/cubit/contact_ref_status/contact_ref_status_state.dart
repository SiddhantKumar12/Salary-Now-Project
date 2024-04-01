part of 'contact_ref_status_cubit.dart';

@immutable
abstract class ContactRefStatusState {}

class ContactRefStatusInitial extends ContactRefStatusState {}

class ContactRefStatusLoading extends ContactRefStatusState {}

class ContactRefStatusLoaded extends ContactRefStatusState {
  final ContactRefStatusModal modal;
  ContactRefStatusLoaded({required this.modal});
}

class ContactRefStatusError extends ContactRefStatusState {
  final String error;
  ContactRefStatusError({required this.error});
}
