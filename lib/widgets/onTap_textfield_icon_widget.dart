import 'package:flutter/material.dart';

import '../utils/color.dart';

class OnTapTextFieldSuffixIconWidget extends StatelessWidget {
  final Icon? icon;
  final VoidCallback? onPressed;
  const OnTapTextFieldSuffixIconWidget({
    super.key,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon ?? const Icon(Icons.keyboard_arrow_down, color: MyColor.turcoiseColor),
      onPressed: onPressed,
    );
  }
}
