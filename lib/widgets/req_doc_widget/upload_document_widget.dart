import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import '../dotted_border_widget.dart';
import '../text_widget.dart';

class UploadDocumentWidget extends StatelessWidget {
  final String buttonTitle;
  final String? secondButtonTitle;
  final String title;
  final String? image;
  final Widget? widget;
  final VoidCallback onTapFirstButton;
  final VoidCallback? onTapSecondButton;
  final bool? twoButton;
  const UploadDocumentWidget({
    super.key,
    required this.buttonTitle,
    required this.onTapFirstButton,
    required this.title,
    this.twoButton,
    this.secondButtonTitle,
    this.widget,
    this.image,
    this.onTapSecondButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title,
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: onTapFirstButton,
          child: MyDottedBorder(
            widget: SizedBox(
              height: 260.h,
              width: double.maxFinite,
              child: image != null
                  ? Image.memory(
                      base64Decode(image!),
                      fit: BoxFit.cover,
                    )
                  : widget ??
                      Center(
                        child: Image.asset(
                          MyImages.camera,
                          width: 80.w,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -1),
          child: twoButton == true
              ? Container(
                  height: 55.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: MyColor.highLightBlueColor,
                    border: Border.all(
                      color: MyColor.turcoiseColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapFirstButton,
                          child: MyText(
                            text: buttonTitle,
                            textAlign: TextAlign.center,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Container(
                        width: 2.w,
                        color: MyColor.turcoiseColor,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapSecondButton,
                          child: MyText(
                            textAlign: TextAlign.center,
                            text: secondButtonTitle ?? "",
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: onTapFirstButton,
                  child: Container(
                    height: 55.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: MyColor.highLightBlueColor,
                      border: Border.all(
                        color: MyColor.turcoiseColor,
                      ),
                    ),
                    child: Center(
                      child: MyText(
                        text: buttonTitle,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
