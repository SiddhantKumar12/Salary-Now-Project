import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_box_continue_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../../widgets/dotted_border_widget.dart';

class AadhaarCardSides extends StatelessWidget {
  const AadhaarCardSides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 11,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const InfoTitleWidget(
                  title: MyWrittenText.takeAPhotoText,
                  subtitle: MyWrittenText.notSharingID,
                ),
                MyDottedBorder(
                    color: MyColor.subtitleTextColor,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: 120.h,
                            color: MyColor.turcoiseColor,
                          ),
                          Column(
                            children: [
                              MyText(
                                text: MyWrittenText.frontOfIDText,
                                fontSize: 20.sp,
                              ),
                              MyText(
                                text: MyWrittenText.pendingText,
                                fontSize: 18.sp,
                                color: MyColor.amberColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                MyDottedBorder(
                    color: MyColor.subtitleTextColor,
                    widget: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: 120.h,
                            color: MyColor.turcoiseColor,
                          ),
                          Column(
                            children: [
                              MyText(
                                text: MyWrittenText.backOfIDText,
                                fontSize: 20.sp,
                              ),
                              MyText(
                                text: MyWrittenText.pendingText,
                                fontSize: 18.sp,
                                color: MyColor.amberColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                const MyText(
                  text: MyWrittenText.chooseUploadText,
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: InfoBoxContinueWidget(onPressed: () {}),
          )
        ],
      ),
    );
  }
}
