part of 'packages_cubit.dart';

@immutable
abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoadingState extends PackagesState {}

class PackagesLoadedState extends PackagesState {
  final PackagesModal modal;
  PackagesLoadedState({required this.modal});
}

class PackagesErrorState extends PackagesState {
  final String error;
  PackagesErrorState({required this.error});
}
