import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/internet_connection/cubit/internet_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/lottie.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state == InternetState.connected) {
              Navigator.pop(context);
            }
          },
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                MyLottie.notInternet3Lottie,
                width: 200.w,
                fit: BoxFit.fitWidth,
              ),
              MyText(
                text: MyWrittenText.noInternet,
                color: MyColor.turcoiseColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(height: 20.h),
              MyButton(
                  text: 'Check Connectivity',
                  onPressed: () {
                    AppSettings.openWIFISettings();
                  })
            ],
          )),
        ),
      ),
    );
  }
}
