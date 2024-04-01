import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/color.dart';

class MyTabBarWidget extends StatelessWidget {
  final String tabOneTitle;
  final String tabTwoTitle;
  final Widget widgetOne;
  final Widget widgetSecond;

  const MyTabBarWidget(
      {Key? key,
      required this.tabOneTitle,
      required this.tabTwoTitle,
      required this.widgetOne,
      required this.widgetSecond})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          physics: BouncingScrollPhysics(parent: BouncingScrollPhysics()),
          tabs: [
            Tab(text: tabOneTitle),
            Tab(text: tabTwoTitle),
          ],
          indicatorColor: MyColor.turcoiseColor,
          labelColor: MyColor.turcoiseColor,
          unselectedLabelColor: MyColor.blackColor,
          unselectedLabelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
          labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: TabBarView(
            children: [widgetOne, widgetSecond],
          ),
        ),
      ],
    );
  }
}
