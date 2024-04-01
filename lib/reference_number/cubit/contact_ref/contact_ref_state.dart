part of 'contact_ref_cubit.dart';

@immutable
abstract class ContactRefState {}

class ContactRefInitial extends ContactRefState {}

class ContactRefLoading extends ContactRefState {}

class ContactRefLoaded extends ContactRefState {
  final ErrorModal errorModal;
  ContactRefLoaded({required this.errorModal});
}

class ContactRefError extends ContactRefState {
  final String error;
  ContactRefError({required this.error});
}
