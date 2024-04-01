import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color.dart';
import '../text_widget.dart';

class InfoTextFieldWidget extends StatelessWidget {
  final String title;
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
  final Color? fillColor;

  const InfoTextFieldWidget({
    Key? key,
    required this.title,
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
    this.initialValue,
    this.hintStyle,
    this.textCapitalization,
    this.inputFormatters,
    this.onChanged,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: const BorderSide(width: 1, color: MyColor.textFieldBorderColor), //<-- SEE HERE
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: title, fontSize: 18.h),
        SizedBox(height: 10.h),
        TextFormField(
          style: TextStyle(fontSize: 16.sp, color: MyColor.placeHolderColor),
          initialValue: initialValue,
          enabled: enabled ?? true,
          autofocus: autoFocus ?? false,
          inputFormatters: inputFormatters,
          cursorColor: MyColor.turcoiseColor,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          scrollPadding: EdgeInsets.zero,
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: textEditingController,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isPass,
          decoration: InputDecoration(
            fillColor: fillColor ?? MyColor.whiteColor,
            errorStyle: const TextStyle(color: MyColor.redColor),
            disabledBorder: border,
            suffixIcon: suffixIcon,
            prefixIcon: icon,
            suffixIconColor: MyColor.turcoiseColor,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14.sp, color: MyColor.subtitleTextColor, fontWeight: FontWeight.w300),
            hoverColor: MyColor.turcoiseColor,
            border: border,
            counterText: "",
            filled: true,
            enabledBorder: border,
            focusedBorder: border,
          ),
        ),
      ],
    );
  }
}
