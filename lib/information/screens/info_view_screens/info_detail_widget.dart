import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/divider_widget.dart';

import '../../../utils/color.dart';
import '../../../widgets/text_widget.dart';

class InfoDetailWidget extends StatelessWidget {
  const InfoDetailWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.noDivider,
  });

  final String title;
  final String subtitle;
  final bool? noDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: MyColor.whiteColor,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: title, fontSize: 18.h),
          SizedBox(height: 3.h),
          MyText(text: subtitle, fontSize: 16.sp, color: MyColor.placeHolderColor),
          SizedBox(height: 7.h),
          noDivider == true ? const SizedBox() : const MyDivider()
        ],
      ),
    );
  }
}
