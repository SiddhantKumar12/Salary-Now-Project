import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/images.dart';

class RejectionScreen extends StatelessWidget {
  final String text;
  final String days;
  const RejectionScreen({
    Key? key,
    required this.text,
    required this.days,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyImages.errorImage,
                  height: 100.h,
                ),
                SizedBox(height: 20.h),
                MyText(
                  text: text.split('@')[0],
                  fontSize: 22.sp,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),
                MyText(
                  text: text.split('@')[1],
                  fontSize: 18.sp,
                  textAlign: TextAlign.center,
                  color: MyColor.subtitleTextColor,
                  fontWeight: FontWeight.w300,
                ),
                SizedBox(height: 30.h),
                MyText(
                  text: text.split('@')[2],
                  fontSize: 20.sp,
                  textAlign: TextAlign.center,
                  color: MyColor.turcoiseColor,
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  // color: MyColor.amberColor,
                  height: 130.h,
                  width: 130.h,
                  child: Stack(
                    children: [
                      Image.asset(
                        MyImages.calenderImage,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: days,
                                fontSize: 35.sp,
                              ),
                              MyText(text: days == '1' ? 'Day' : 'Days'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
