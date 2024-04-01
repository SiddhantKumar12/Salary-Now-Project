part of 'residential_detail_cubit.dart';

@immutable
abstract class ResiDetailState {}

class ResidentialDetailInitial extends ResiDetailState {}

class ResidentialDetailLoading extends ResiDetailState {}

class ResidentialDetailLoaded extends ResiDetailState {
  final ResidentialDetailsModal residentialDetailsModal;
  ResidentialDetailLoaded({required this.residentialDetailsModal});
}

class ResidentialDetailError extends ResiDetailState {
  final String error;
  ResidentialDetailError({required this.error});
}
