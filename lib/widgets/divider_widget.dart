import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

class MyDivider extends StatelessWidget {
  final Color? color;
  const MyDivider({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w, bottom: 0.h),
      child: Divider(
        color: color ?? MyColor.dividerColor,
        thickness: 1,
      ),
    );
  }
}
