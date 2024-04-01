import 'dart:io' show Platform;

class PlatformDetection {
  static bool isPlatform() {
    if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }
}
