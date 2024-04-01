import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit() : super(2000);

  void updateSliderValue(double newValue) {
    emit(newValue);
  }
}
