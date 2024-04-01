import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color.dart';
import '../../utils/written_text.dart';
import '../divider_widget.dart';
import '../text_widget.dart';

class ProfileInfoCard extends StatelessWidget {
  final String? rowFirstTitle;
  final String? rowSecondTitle;
  final String? rowThirdTitle;
  final String? rowFourthTitle;
  final String? rowFifthTitle;
  final bool? isBankDetail;
  final VoidCallback? onPressed;
  final String? accNumberData;
  final String? bankNameData;
  final String? branchAddData;
  final String? ifscData;

  const ProfileInfoCard({
    super.key,
    this.rowFirstTitle,
    this.rowSecondTitle,
    this.rowThirdTitle,
    this.rowFourthTitle,
    this.rowFifthTitle,
    this.isBankDetail = false,
    this.accNumberData,
    this.bankNameData,
    this.branchAddData,
    this.ifscData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 12.w, bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: MyColor.subtitleTextColor.withOpacity(0.5),
        ),
      ),
      width: double.maxFinite,
      child: isBankDetail == true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.contacts, size: 24.h),
                        SizedBox(width: 10.w),
                        MyText(
                          text: rowFirstTitle!,
                          fontSize: 20.sp,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye,
                        size: 24.h,
                        color: MyColor.purpleColor,
                      ),
                    )
                  ],
                ),
                const MyDivider(),
                Row(
                  children: [
                    Expanded(
                        child: MyText(
                      text: MyWrittenText.accountNumberText,
                      color: MyColor.subtitleTextColor,
                      fontWeight: FontWeight.w300,
                    )),
                    Expanded(
                        child: MyText(
                      text: MyWrittenText.bankNameText,
                      color: MyColor.subtitleTextColor,
                      fontWeight: FontWeight.w300,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: MyText(text: accNumberData!, fontSize: 18.sp)),
                    Expanded(child: MyText(text: bankNameData!, fontSize: 18.sp)),
                  ],
                ),
                const MyDivider(),
                Row(
                  children: [
                    Expanded(
                        child: MyText(
                      text: MyWrittenText.branchNameText,
                      color: MyColor.subtitleTextColor,
                      fontWeight: FontWeight.w300,
                    )),
                    Expanded(
                        child: MyText(
                      text: MyWrittenText.iFSCText,
                      color: MyColor.subtitleTextColor,
                      fontWeight: FontWeight.w300,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: MyText(text: branchAddData!, fontSize: 18.sp)),
                    Expanded(child: MyText(text: ifscData!, fontSize: 18.sp)),
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.contacts, size: 24.h),
                        SizedBox(width: 10.w),
                        MyText(
                          text: rowFirstTitle!,
                          fontSize: 20.sp,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye,
                        size: 24.h,
                        color: MyColor.purpleColor,
                      ),
                    )
                  ],
                ),
                const MyDivider(),
                MyText(
                  text: rowSecondTitle!,
                  color: MyColor.subtitleTextColor,
                  fontWeight: FontWeight.w300,
                ),
                MyText(text: rowThirdTitle!, fontSize: 18.sp),
                const MyDivider(),
                MyText(
                  text: rowFourthTitle!,
                  color: MyColor.subtitleTextColor,
                  fontWeight: FontWeight.w300,
                ),
                MyText(text: rowFifthTitle!, fontSize: 18.sp),
              ],
            ),
    );
  }
}
