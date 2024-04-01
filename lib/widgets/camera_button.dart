import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

class MyCameraButton extends StatelessWidget {
  final VoidCallback onTap;
  const MyCameraButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 44.r,
        backgroundColor: MyColor.blackColor,
        child: CircleAvatar(
          radius: 42.r,
          backgroundColor: MyColor.whiteColor,
          child: CircleAvatar(
            radius: 40.r,
            backgroundColor: MyColor.turcoiseColor,
            child: Icon(
              Icons.camera_alt_rounded,
              size: 45.sp,
              color: MyColor.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
