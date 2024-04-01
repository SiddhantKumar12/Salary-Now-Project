import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/url_launcher_helper.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/logo_image_widget.dart';
import '../../utils/lottie.dart';

class LoginContactUsScreen extends StatelessWidget {
  const LoginContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: MyWrittenText.contactUS),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 150.h),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const MyLogoImageWidget(),
            SizedBox(height: 20.h),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: MyWrittenText.contactUsSubTitle,
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w300, color: MyColor.blackColor),
                    children: [
                      TextSpan(
                        text: MyWrittenText.salaryNowGmail,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w300,
                          color: MyColor.redColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            MyUrlLauncher.launchEmail();
                          },
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(20.w, -20.h),
                  child: GestureDetector(
                    onTap: () {
                      MyUrlLauncher.launchEmail();
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Lottie.asset(
                        MyLottie.gmailLottie,
                        width: 100.w,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
