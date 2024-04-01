import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<int> {
  Timer? _timer;

  TimerCubit() : super(60);

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state == 0) {
          timer.cancel();
        } else {
          emit(state - 1);
        }
      },
    );
  }

  void restartTimer() {
    _timer?.cancel();
    emit(60);
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
