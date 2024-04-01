import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/written_text.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? wordSpacing;
  final double? textScaleFactor;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? maxFontSize;
  final double? minFontSize;
  final double? lineHeight;
  final TextDecoration? textDecoration;

  const MyText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.wordSpacing,
    this.textScaleFactor,
    this.textAlign,
    this.letterSpacing,
    this.textOverflow,
    this.maxLines,
    this.maxFontSize,
    this.minFontSize,
    this.lineHeight,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      textAlign: textAlign,
      style: TextStyle(
        decoration: textDecoration,
        height: lineHeight,
        overflow: textOverflow,
        fontSize: fontSize ?? 16.sp,
        color: color ?? MyColor.blackColor,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.2,
        fontFamily: MyWrittenText.roboto,
      ),
    );
  }
}
