import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../utils/color.dart';
import '../utils/lottie.dart';
import '../utils/written_text.dart';
import 'dotted_border_widget.dart';

class EmptyContainer extends StatelessWidget {
  final String text;
  const EmptyContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyDottedBorder(
      color: MyColor.subtitleTextColor,
      widget: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(bottom: 30.h),
        child: Center(
          child: Column(
            children: [
              Lottie.asset(
                MyLottie.boxEmptyLottie,
                height: 230.h,
                width: 200.w,
              ),
              MyText(
                text: text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
