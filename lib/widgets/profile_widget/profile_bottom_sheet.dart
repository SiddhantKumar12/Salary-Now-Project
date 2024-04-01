import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/textField_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/color.dart';
import '../../utils/written_text.dart';

class ProfileOTPSheet {
  static bottomSheetWidget({required BuildContext context, required TextEditingController textEditingController}) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 320.h,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const InfoTitleWidget(
                    title: MyWrittenText.otpVerificationText,
                    subtitle: MyWrittenText.otpRegisterText,
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textEditingController: textEditingController,
                    validator: (value) {
                      if (value!.length < 6 || value.isEmpty) {
                        return MyWrittenText.enterCorrectOTPText;
                      }
                      return null;
                    },
                    maxLength: 10,
                    hintText: MyWrittenText.enterOTP,
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const MyText(
                          text: MyWrittenText.resendOtpText,
                          fontWeight: FontWeight.w300,
                          color: MyColor.subtitleTextColor,
                        ),
                        SizedBox(height: 20.h),
                        MyButton(
                            text: MyWrittenText.verifyOTPText,
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
