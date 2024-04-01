import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';

import '../utils/platform_detect.dart';

class MyTextField extends StatelessWidget {
  final bool? autoFocus;
  final bool? enabled;
  final TextEditingController textEditingController;
  final bool isPass;
  final String? hintText;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextInputType? textInputType;
  final Icon? icon;
  final Widget? suffixIcon;
  final int? maxLines;
  final FormFieldValidator<String?>? validator;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const MyTextField(
      {Key? key,
      required this.textEditingController,
      this.textInputType,
      this.hintText,
      this.icon,
      this.suffixIcon,
      this.isPass = false,
      this.validator,
      this.maxLines,
      this.textInputAction,
      this.maxLength,
      this.autoFocus,
      this.enabled,
      this.inputFormatters,
      this.hintStyle,
      this.textCapitalization,
      this.initialValue,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformDetection.isPlatform()
        ? TextFormField(
            style: TextStyle(fontSize: 16.sp, color: MyColor.placeHolderColor),
            initialValue: initialValue,
            enabled: enabled ?? true,
            autofocus: autoFocus ?? false,
            scrollPadding: EdgeInsets.zero,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: textEditingController,
            textInputAction: textInputAction ?? TextInputAction.next,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: MyColor.redColor),
              suffixIcon: suffixIcon,
              prefixIcon: icon,
              hintText: hintText,
              hintStyle: hintStyle ?? TextStyle(color: MyColor.placeHolderColor, fontSize: 16.sp),
              counterText: "",
              filled: false,
              contentPadding: EdgeInsets.symmetric(vertical: 13.h),
            ),
            keyboardType: textInputType,
            obscureText: isPass,
            onChanged: onChanged,
          )
        : CupertinoTextField(
            enabled: enabled ?? true,
            autofocus: autoFocus ?? false,
            scrollPadding: EdgeInsets.zero,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            controller: textEditingController,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: textInputType,
            obscureText: isPass,
            decoration: BoxDecoration(),
          );
  }
}
