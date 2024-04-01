import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum InternetState { initial, connected, disconnected }

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetCubit() : super(InternetState.initial) {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        emit(InternetState.connected);
      } else {
        emit(InternetState.disconnected);
      }
    });
  }

  static InternetCubit get(context) => BlocProvider.of(context);

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
