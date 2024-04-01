import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/color.dart';
import '../elevated_button_widget.dart';

class DashBoardListTileOne extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String image;
  final String textButtonTitle;

  const DashBoardListTileOne({
    super.key,
    required this.title,
    required this.image,
    required this.textButtonTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                  width: 40.w,
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 50.w, right: 10.w),
                    tileColor: const Color(0xffF7F7F7),
                    title: MyText(text: title, color: MyColor.titleTextColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.r),
                        bottomRight: Radius.circular(50.r),
                      ),
                    ),
                    trailing: SizedBox(
                      height: 40.h,
                      width: 120.w,
                      child: MyButton(
                        text: textButtonTitle,
                        onPressed: onPressed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: 36.r,
              backgroundColor: MyColor.whiteColor,
              child: CircleAvatar(
                radius: 32.r,
                backgroundColor: MyColor.whiteColor,
                backgroundImage: AssetImage(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashBoardListTileTwo extends StatelessWidget {
  final String title;
  final String? trailingTitle;
  final Color? trailingColor;
  final Widget? trailingWidget;
  final Widget? subtitleWidget;
  final Widget? leadingWidget;
  final VoidCallback? onTap;

  const DashBoardListTileTwo({
    Key? key,
    required this.title,
    this.trailingTitle,
    this.trailingColor,
    this.trailingWidget,
    this.subtitleWidget,
    this.leadingWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Transform.translate(
        offset: Offset(0, -5.h),
        child: Center(
          child: ListTile(
            onTap: onTap,
            tileColor: MyColor.whiteColor,
            leading: leadingWidget,
            title: MyText(
              text: title,
              fontWeight: FontWeight.w300,
            ),
            subtitle: subtitleWidget,
            trailing: trailingTitle == null
                ? trailingWidget
                : MyText(
                    text: trailingTitle!,
                    fontWeight: FontWeight.w300,
                    fontSize: 16.sp,
                    color: trailingColor,
                  ),
          ),
        ),
      ),
    );
  }
}
