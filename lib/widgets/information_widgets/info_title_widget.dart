import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/written_text.dart';

import '../text_widget.dart';

class InfoTitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? height;
  final Color? color;
  const InfoTitleWidget({Key? key, required this.title, this.subtitle, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title,
          fontSize: 22.sp,
          color: color ?? MyColor.titleTextColor,
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5.h),
        MyText(
          text: subtitle ?? MyWrittenText.chooseUploadText,
          fontSize: 14.sp,
          fontWeight: FontWeight.w300,
          color: color ?? MyColor.subtitleTextColor,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
