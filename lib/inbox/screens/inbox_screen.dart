import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/tab_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/color.dart';
import '../../widgets/dotted_border_widget.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: InfoCustomAppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, top: 20.h, right: 30.w),
              child: const InfoTitleWidget(
                title: MyWrittenText.inboxTitleText,
                subtitle: MyWrittenText.inboxSubtitleText,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: MyTabBarWidget(
                  tabOneTitle: MyWrittenText.notificationText,
                  tabTwoTitle: MyWrittenText.messageText,
                  widgetOne: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.h, left: 30.w, right: 30.w, bottom: 20.h),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 330.h,
                            child: MyDottedBorder(
                              color: MyColor.subtitleTextColor,
                              widget: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.place),
                                  SizedBox(height: 10.h),
                                  const MyText(
                                    fontWeight: FontWeight.w300,
                                    text: MyWrittenText.noNotificationText,
                                    color: MyColor.subtitleTextColor,
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widgetSecond: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 30.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              color: MyColor.highLightBlueColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "Dear Customer this is only a testing message. ",
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: "From: Salary Now",
                                      fontSize: 12,
                                      color: MyColor.turcoiseColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    MyText(
                                      text: DateTime.now().toString().substring(0, 10),
                                      fontSize: 12,
                                      color: MyColor.turcoiseColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
