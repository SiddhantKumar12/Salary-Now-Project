part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModal profileModal;
  ProfileLoaded({required this.profileModal});
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}
