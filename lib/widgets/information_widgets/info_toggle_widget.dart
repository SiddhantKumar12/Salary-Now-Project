import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/written_text.dart';
import '../../utils/color.dart';
import '../text_widget.dart';

class PersonalInfoToggleWidget extends StatelessWidget {
  final int activeIndex;
  const PersonalInfoToggleWidget({Key? key, required this.activeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildColumn(text: MyWrittenText.basic, index: 0),
          buildColumn(text: MyWrittenText.personal, index: 1),
          buildColumn(text: MyWrittenText.contact, index: 2),
        ],
      ),
    );
  }

  Column buildColumn({required String text, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24.h,
          backgroundColor: MyColor.turcoiseColor,
          child: CircleAvatar(
            backgroundColor: activeIndex >= index ? MyColor.turcoiseColor : MyColor.whiteColor,
            radius: 22.h,
            child: MyText(
              text: "${index + 1}",
              color: activeIndex >= index ? MyColor.whiteColor : MyColor.turcoiseColor,
              fontSize: 20.h,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        MyText(
          text: text,
          fontSize: 18.h,
          fontWeight: activeIndex >= index ? FontWeight.w400 : FontWeight.w300,
        )
      ],
    );
  }
}
