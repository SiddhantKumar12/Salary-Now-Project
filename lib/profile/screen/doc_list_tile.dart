import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import '../../widgets/text_widget.dart';

class DocumentListTile extends StatelessWidget {
  final String image;
  final String title;
  final bool showIndicator;
  final bool isDocument;
  final VoidCallback onTap;
  const DocumentListTile({
    Key? key,
    required this.title,
    required this.showIndicator,
    this.isDocument = false,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.containerBGColor,
        border: Border.all(color: MyColor.subtitleTextColor, width: 1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      height: 80.h,
      child: Center(
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          onTap: onTap,
          contentPadding: EdgeInsets.only(left: 15.w, right: 10.w),
          iconColor: Colors.black,
          // tileColor: MyColor.highLightBlueColor.withOpacity(0.5),
          leading: Image.asset(
            image,
            height: 40.h,
            width: 40.w,
          ),
          title: MyText(
            text: title,
            fontSize: 16.sp,
          ),
          trailing: Container(
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: MyColor.subtitleTextColor.withOpacity(0.15),
              ),
              child: isDocument
                  ? Center(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(
                          text: 'OPEN',
                          fontSize: 14.sp,
                          color: MyColor.blackColor,
                        ),
                      ],
                    ))
                  : showIndicator
                      ? Center(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              MyImages.sandTimerImage,
                              height: 16.h,
                              width: 16.w,
                            ),
                            MyText(
                              text: 'Pending',
                              fontSize: 13.sp,
                              color: MyColor.amberColor,
                            ),
                          ],
                        ))
                      : Center(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Transform.translate(
                              offset: Offset(-5.w, 0),
                              child: CircleAvatar(
                                radius: 11.r,
                                backgroundColor: MyColor.greenColor,
                                child: Icon(
                                  Icons.done,
                                  size: 16.sp,
                                  color: MyColor.whiteColor,
                                ),
                              ),
                            ),
                            MyText(
                              text: 'View',
                              fontSize: 16.sp,
                              color: MyColor.greenColor,
                            ),
                          ],
                        ))),
        ),
      ),
    );
  }
}
