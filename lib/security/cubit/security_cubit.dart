import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_device/safe_device.dart';

part 'security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit() : super(SecurityInitial());

  static SecurityCubit get(context) => BlocProvider.of(context);

  Future<void> checkDebugging() async {
    bool isDebugging = await SafeDevice.isDevelopmentModeEnable;
    // bool isRealDevice = await SafeDevice.isRealDevice;

    if (isDebugging == true) {
      emit(SecurityDialogState(isDebugging: isDebugging));
    } else {
      emit(SecurityNoDialogState());
    }
  }

  @override
  Future<void> close() {
    checkDebugging();
    return super.close();
  }
}
