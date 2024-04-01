import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color.dart';
import '../../utils/written_text.dart';
import '../elevated_button_widget.dart';

class InfoBoxContinueWidget extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;

  const InfoBoxContinueWidget({
    super.key,
    required this.onPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: MyColor.whiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 1.r,
            color: MyColor.subtitleTextColor,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              text: title ?? MyWrittenText.continueText,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
