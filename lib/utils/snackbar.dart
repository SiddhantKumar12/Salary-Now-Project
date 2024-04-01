import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/text_widget.dart';

class MySnackBar {
  static Flushbar? currentFlushbar;

  static void showInternetSnackbar(BuildContext context) {
    if (currentFlushbar != null) {
      currentFlushbar!.dismiss();
    }

    currentFlushbar = Flushbar(
      message: "Internet Connected",
      icon: Icon(
        Icons.wifi,
        size: 28.0,
        color: Colors.blue[300],
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }

  static void showNotInternetSnackbar(BuildContext context) {
    if (currentFlushbar != null) {
      currentFlushbar!.dismiss();
    }

    currentFlushbar = Flushbar(
      message: "Internet Disconnected",
      icon: Icon(
        Icons.signal_wifi_bad_outlined,
        size: 28.0,
        color: Colors.blue[300],
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(days: 1),
      leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      content: Center(
        child: MyText(
          text: text,
          color: MyColor.whiteColor,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: MyColor.turcoiseColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 80.h, left: 20.h, right: 20.h),
      elevation: 20.h,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // static void internetSnackBar(BuildContext context, String text, Color color) {
  //   final snackBar = SnackBar(
  //     content: MyText(
  //       text: text,
  //       color: MyColor.whiteColor,
  //     ),
  //     duration: Duration(seconds: 5),
  //     backgroundColor: color,
  //   );
  //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
