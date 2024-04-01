import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/bottom_nav_bar/cubit/navbar_cubit.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../../utils/color.dart';

class InfoCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final bool? centerTitle;
  final bool? leading;
  final bool popScreen;
  final int? navigatePopNumber;

  const InfoCustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.title = "",
    this.centerTitle,
    this.leading = true,
    this.popScreen = true,
    this.navigatePopNumber,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ?? true,
      title: MyText(
        text: title!,
        fontWeight: FontWeight.w400,
        fontSize: 25.sp,
        color: MyColor.titleTextColor,
      ),
      elevation: 0,
      leading: leading == true
          ? Padding(
              padding: EdgeInsets.only(left: 18.w),
              child: IconButton(
                onPressed: () {
                  if (popScreen == true) {
                    Navigator.pop(context);
                  } else {
                    var cubit = NavbarCubit.get(context);
                    cubit.changeBottomNavBar(0);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: MyColor.blackColor,
                ),
              ),
            )
          : null,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 13.w),
          child: navigatePopNumber != null
              ? IconButton(
                  onPressed: () {
                    NavbarCubit.get(context).changeBottomNavBar(0);
                    for (int i = 0; i < navigatePopNumber!; i++) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.home,
                    color: MyColor.turcoiseColor,
                    size: 35.sp,
                  ),
                )
              : const SizedBox(),
        )
      ],
      backgroundColor: MyColor.whiteColor,
    );
  }
}
