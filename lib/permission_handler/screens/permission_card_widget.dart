import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color.dart';
import '../../widgets/text_widget.dart';

class PermissionCardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;

  const PermissionCardWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: MyColor.containerBGColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 2.0,
                spreadRadius: 1, //New
              )
            ],
            // color: MyColor.whiteColor,
          ),
          width: double.maxFinite,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(image, height: 50.h, width: 50.h),
                  SizedBox(width: 10.w),
                  SizedBox(width: 5.w),
                  MyText(
                    text: title,
                    fontSize: 20.sp,
                  )
                ],
              ),
              SizedBox(height: 10.h),
              MyText(
                text: subTitle,
                fontSize: 14.sp,
                textAlign: TextAlign.justify,
                color: MyColor.subtitleTextColor,
                fontWeight: FontWeight.w400,
                // letterSpacing: 0.5,
              )
            ],
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
