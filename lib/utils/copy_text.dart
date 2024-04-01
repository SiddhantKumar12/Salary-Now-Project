import 'package:flutter/services.dart';

class CopyText {
  static getText(String? text) async {
    await Clipboard.setData(ClipboardData(text: text ?? ''));
  }
}
