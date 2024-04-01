import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/permission_handler/network/call_log_modal.dart';
import '../../utils/color.dart';
import '../../widgets/text_widget.dart';

class MyRefDialogBox {
  static void showContact({
    required BuildContext context,
    required List<MyCallLogModal> callLogData,
    required Function(String) name,
    required Function(String) number,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: 'Select Any Reference',
                    fontSize: 23.sp,
                    color: MyColor.turcoiseColor,
                  ),
                  SizedBox(height: 20.h),
                  ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.1),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: callLogData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            name(callLogData[index].name!);
                            number(callLogData[index].phone!);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MyText(
                                    text: callLogData[index].name!,
                                    textAlign: TextAlign.start,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Expanded(
                                  child: MyText(
                                    text: callLogData[index].phone!,
                                    textAlign: TextAlign.end,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
