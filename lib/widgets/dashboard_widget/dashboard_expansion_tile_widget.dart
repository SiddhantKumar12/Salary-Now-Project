import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color.dart';
import '../text_widget.dart';

class DashBoardExpansionTIle extends StatelessWidget {
  final Widget? leading;
  final String subtitle;
  final String title;
  final Color? titleColor;
  final List<Widget> children;
  const DashBoardExpansionTIle({
    super.key,
    this.leading,
    required this.subtitle,
    required this.title,
    required this.children,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: MyColor.whiteColor,
        leading: leading,
        iconColor: MyColor.turcoiseColor,
        title: Transform.translate(
          offset: Offset(-10.w, 0),
          child: MyText(
            text: title,
            fontSize: 20.sp,
            color: titleColor,
          ),
        ),
        subtitle: Transform.translate(
          offset: Offset(-10.w, 0),
          child: MyText(
            text: subtitle,
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        children: children,
      ),
    );
  }
}
