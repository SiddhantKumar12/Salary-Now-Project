part of 'faq_cubit.dart';

@immutable
abstract class FaqState {}

class FaqInitial extends FaqState {}

class FaqLoading extends FaqState {}

class FaqLoaded extends FaqState {
  final FAQModal faqModal;
  FaqLoaded({required this.faqModal});
}

class FaqError extends FaqState {
  final String error;
  FaqError({required this.error});
}
