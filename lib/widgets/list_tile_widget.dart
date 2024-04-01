import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/platform_detect.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../utils/color.dart';

class MyListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final ShapeBorder? shape;
  final String title;
  final Color? tileColor;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback onTap;
  const MyListTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.color,
    this.shape,
    this.contentPadding,
    this.tileColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformDetection.isPlatform()
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ListTile(
              onTap: onTap,
              tileColor: tileColor ?? MyColor.whiteColor,
              contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
              shape: shape ??
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r), side: BorderSide(color: MyColor.turcoiseColor)),
              title: MyText(
                text: title,
                color: color ?? MyColor.turcoiseColor,
                fontSize: 18.sp,
              ),
              leading: leading,
              trailing: trailing ??
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: MyColor.turcoiseColor,
                  ),
            ),
          )
        : CupertinoListTile(
            title: Text(title),
            leading: leading,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: MyColor.turcoiseColor,
            ));
  }
}
