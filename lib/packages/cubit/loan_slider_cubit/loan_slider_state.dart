part of 'loan_slider_cubit.dart';

@immutable
abstract class LoanSliderState {}

class LoanSliderInitial extends LoanSliderState {}

class LoanSliderLoading extends LoanSliderState {}

class LoanSlider2Loading extends LoanSliderState {}

class LoanSliderLoaded extends LoanSliderState {
  final LoanCalculatorModal modal;
  LoanSliderLoaded({required this.modal});
}

class LoanSliderError extends LoanSliderState {
  final String error;
  LoanSliderError({required this.error});
}

class LoanSlider2Error extends LoanSliderState {
  final String error;
  LoanSlider2Error({required this.error});
}
