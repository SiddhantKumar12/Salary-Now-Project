import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../utils/color.dart';

class MyErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const MyErrorWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset(MyLottie.pendingLottie),
            const MyText(
              text: 'We\'re sorry! Unable to load this page. Please try again.',
              color: MyColor.subtitleTextColor,
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            MyButton(
              text: 'Try Again',
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
