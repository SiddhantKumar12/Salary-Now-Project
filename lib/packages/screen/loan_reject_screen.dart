import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/logo_image_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../../routing/route_path.dart';
import '../../utils/images.dart';
import '../../utils/lottie.dart';
import '../../utils/url_launcher_helper.dart';

class LoanCriteriaScreen extends StatelessWidget {
  const LoanCriteriaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoCustomAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.h, top: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              MyImages.logoImage,
              width: 200.w,
              fit: BoxFit.fitWidth,
            ),
            MyText(
              text: MyWrittenText.loanCriteriaTitle1,
              fontWeight: FontWeight.w300,
              fontSize: 20.sp,
            ),
            Column(
              children: [
                buildContainer(MyWrittenText.loanCriteriaTitle2),
                buildContainer(MyWrittenText.loanCriteriaTitle3),
                buildContainer(MyWrittenText.loanCriteriaTitle4),
                buildContainer(MyWrittenText.loanCriteriaTitle5),
                buildContainer(MyWrittenText.loanCriteriaTitle6),
                buildContainer(MyWrittenText.loanCriteriaTitle7),
              ],
            ),
            RichText(
              text: TextSpan(
                text: MyWrittenText.loanCriteriaTitle8,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300, color: MyColor.blackColor),
                children: [
                  TextSpan(
                    text: MyWrittenText.loanCriteriaTitle9,
                    style: TextStyle(
                      fontSize: 18.sp,
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
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutePath.dashBoardContactUsScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const MyText(text: MyWrittenText.helloText),
                    SvgPicture.asset(
                      MyImages.supportIcon,
                      fit: BoxFit.fitHeight,
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildContainer(String text) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            color: MyColor.containerBGColor,
            width: double.maxFinite,
            child: MyText(text: text)),
        SizedBox(height: 5.h)
      ],
    );
  }
}
