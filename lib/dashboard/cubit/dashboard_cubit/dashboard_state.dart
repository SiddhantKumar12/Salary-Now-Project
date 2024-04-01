part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashBoardModal dashBoardModal;
  DashboardLoaded({required this.dashBoardModal});
}

class DashboardError extends DashboardState {
  final String error;
  DashboardError({required this.error});
}
