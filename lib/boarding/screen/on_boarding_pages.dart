import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../utils/color.dart';
import '../../widgets/text_widget.dart';

class OnBoardPages extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const OnBoardPages({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.only(bottom: 150.h),
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300.h,
              width: 300.w,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                  image,
                  width: 260.w,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  text: title,
                  fontSize: 26.sp,
                  textAlign: TextAlign.center,
                  color: MyColor.blackColor,
                ),
                SizedBox(height: 4.h),
                MyText(
                  text: subtitle,
                  fontSize: 16.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
