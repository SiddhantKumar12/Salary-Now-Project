import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/text_widget.dart';

class MyButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final VoidCallback onPressed;
  final FontWeight? fontWeight;
  final Color? buttonColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final double? fontSize;
  final TextAlign? textAlign;
  const MyButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.height,
      this.width,
      this.fontWeight,
      this.buttonColor,
      this.textColor,
      this.borderSide,
      this.fontSize,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      width: width ?? 242.w,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: MyColor.whiteColor,
            backgroundColor: buttonColor ?? MyColor.turcoiseColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
                side: borderSide ?? BorderSide(color: MyColor.transparentColor, width: 0)),
          ),
          child: MyText(
            text: text,
            textAlign: textAlign,
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight,
            color: textColor ?? MyColor.whiteColor,
          )),
    );
  }
}
