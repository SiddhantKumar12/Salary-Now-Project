import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/color.dart';
import '../utils/images.dart';

class MyProfileAvatar extends StatelessWidget {
  final double? outerRadius;
  final double? innerRadius;
  final String? imageUrl;

  const MyProfileAvatar({
    super.key,
    this.outerRadius,
    this.innerRadius,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius ?? 50.r,
      backgroundColor: MyColor.turcoiseColor,
      child: imageUrl == null
          ? CircleAvatar(
              radius: innerRadius ?? 48.r,
              backgroundImage: const AssetImage(MyImages.profileImage),
            )
          : CircleAvatar(
              radius: innerRadius ?? 48.r,
              backgroundImage: NetworkImage(imageUrl!),
            ),
    );
  }
}
