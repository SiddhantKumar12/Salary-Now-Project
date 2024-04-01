import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/color.dart';
import '../../utils/written_text.dart';
import '../../widgets/elevated_button_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyText(
                    text: MyWrittenText.privatePolicyText,
                    fontSize: 30.sp,
                    color: MyColor.turcoiseColor,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.justify,
                  ),
                  RichText(
                    text: TextSpan(
                      text: MyWrittenText.termsConditionsText,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: MyColor.blackColor,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                            text: MyWrittenText.doNotAgreeText,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                        TextSpan(text: MyWrittenText.readTermsText)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: MyColor.blackColor, // Your color
                          ),
                          child: Checkbox(
                            value: false,
                            onChanged: (bool? value) {},
                          ),
                        ),
                        MyText(
                          text: MyWrittenText.acceptPPText,
                          fontSize: 22.sp,
                          color: MyColor.purpleColor,
                        )
                      ],
                    ),
                    MyButton(text: MyWrittenText.iAgreeText, onPressed: () {}),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
