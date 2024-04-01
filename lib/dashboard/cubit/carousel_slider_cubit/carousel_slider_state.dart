part of 'carousel_slider_cubit.dart';

@immutable
abstract class CarouselSliderState {}

class CarouselSliderInitial extends CarouselSliderState {}

class CarouselSliderLoading extends CarouselSliderState {}

class CarouselSliderLoaded extends CarouselSliderState {
  final CarouselSliderModal carouselSliderModal;
  CarouselSliderLoaded({required this.carouselSliderModal});
}

class CarouselSliderError extends CarouselSliderState {
  final String error;
  CarouselSliderError({required this.error});
}
