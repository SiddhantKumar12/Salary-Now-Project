import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

import '../utils/color.dart';

class MyDottedBorder extends StatelessWidget {
  final Color? color;
  final Widget widget;
  const MyDottedBorder({
    super.key,
    required this.widget,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: color ?? MyColor.turcoiseColor,
      strokeWidth: 1,
      dashPattern: const <double>[5, 5],
      strokeCap: StrokeCap.butt,
      child: widget,
    );
  }
}
