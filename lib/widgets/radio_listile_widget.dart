import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../utils/color.dart';

class MyRadioListTile extends StatelessWidget {
  const MyRadioListTile({
    super.key,
    required this.groupValue,
    required this.value,
    required this.text,
    this.secondaryText,
    this.onChanged,
    required this.onTap,
  });
  final String text;
  final String? secondaryText;
  final int groupValue;
  final int value;
  final VoidCallback onTap;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: Radio(
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: MyText(
                      text: text,
                      fontSize: 15.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          secondaryText != null
              ? MyText(
                  text: secondaryText!,
                  fontSize: 15.sp,
                  color: MyColor.subtitleTextColor,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
