import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/color.dart';
import '../../utils/lottie.dart';
import '../../utils/written_text.dart';

class MaintenanceScreen extends StatelessWidget {
  final bool isError;
  const MaintenanceScreen({Key? key, this.isError = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isError
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    MyLottie.notInternet3Lottie,
                    width: 200.w,
                    fit: BoxFit.fitWidth,
                  ),
                  MyText(
                    text: MyWrittenText.noInternet,
                    color: MyColor.turcoiseColor,
                    textAlign: TextAlign.center,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 20.h),
                  MyText(
                    text: MyWrittenText.noInternetSubtitle,
                    color: MyColor.subtitleTextColor,
                    textAlign: TextAlign.center,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ))
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    MyLottie.maintenance,
                    width: 270.w,
                    fit: BoxFit.fitWidth,
                  ),
                  MyText(
                    text: MyWrittenText.maintenanceTitle,
                    textAlign: TextAlign.center,
                    color: MyColor.turcoiseColor,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: 20.h),
                ],
              )));
  }
}
