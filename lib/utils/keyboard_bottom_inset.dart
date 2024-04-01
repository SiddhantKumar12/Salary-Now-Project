import 'package:flutter/cupertino.dart';

class MyKeyboardInset {
  static bool hideWidgetByKeyboard(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    if (!isKeyboard) {
      return true;
    }
    return false;
  }

  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
