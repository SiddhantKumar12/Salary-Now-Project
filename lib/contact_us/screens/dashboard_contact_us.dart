import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/dashboard/cubit/delete_callback/delete_callback_cubit.dart';
import 'package:salarynow/dashboard/cubit/req_callback/req_callback_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/divider_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/lottie.dart';
import '../../utils/url_launcher_helper.dart';

class DashBoardContactUsScreen extends StatelessWidget {
  const DashBoardContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const InfoCustomAppBar(title: MyWrittenText.contactUS),
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocListener<ReqCallbackCubit, ReqCallbackState>(
                    listener: (context, state) {
                      if (state is ReqCallbackLoading) {
                        MyScreenLoader.onScreenLoader(context);
                      }
                      if (state is ReqCallbackLoaded) {
                        Navigator.pop(context);
                        MySnackBar.showSnackBar(context, state.modal.responseMsg!);
                      }
                      if (state is ReqCallbackError) {
                        Navigator.pop(context);

                        MySnackBar.showSnackBar(context, state.error);
                      }
                    },
                    child: DashBoardContactCard(
                      title: MyWrittenText.reqCallback,
                      subtitle: MyWrittenText.reqCallbackSub,
                      buttonTitle: 'Callback',
                      lottiePath: MyLottie.callRingingLottie,
                      onPressed: () {
                        var cubit = ReqCallbackCubit.get(context);
                        cubit.getReqCallback();
                      },
                    ),
                  ),
                  const MyDivider(),
                  DashBoardContactCard(
                    title: MyWrittenText.writeGmail,
                    subtitle: MyWrittenText.writeGmailSub,
                    buttonTitle: 'Send',
                    lottiePath: MyLottie.blueMailLottie,
                    onPressed: () {
                      MyUrlLauncher.launchEmail();
                    },
                  ),
                  const MyDivider(),
                  DashBoardContactCard(
                    title: MyWrittenText.techIssue,
                    subtitle: MyWrittenText.techIssueSub,
                    buttonTitle: 'Send',
                    lottiePath: MyLottie.blueMailLottie,
                    onPressed: () {
                      MyUrlLauncher.launchEmail();
                    },
                  ),
                  const MyDivider(),
                  BlocListener<DeleteCallbackCubit, DeleteCallbackState>(
                    listener: (context, state) {
                      if (state is DeleteCallbackLoading) {
                        MyScreenLoader.onScreenLoader(context);
                      }
                      if (state is DeleteCallbackLoaded) {
                        Navigator.pop(context);
                        MyDialogBox.showDeleteReqResponseDialog(context, state.modal.responseMsg!);
                      }
                      if (state is DeleteCallbackError) {
                        Navigator.pop(context);

                        MySnackBar.showSnackBar(context, state.error);
                      }
                    },
                    child: DashBoardContactCard(
                      title: MyWrittenText.deleteData,
                      subtitle: MyWrittenText.deleteDataSub,
                      buttonTitle: 'Delete',
                      borderSide: const BorderSide(color: Colors.grey),
                      lottiePath: MyLottie.deleteIconLottie,
                      buttonColor: MyColor.whiteColor,
                      buttonTextColor: MyColor.redColor,
                      onPressed: () {
                        MyDialogBox.showDeleteReqCheckDialog(
                            context: context,
                            onTap: () {
                              Navigator.pop(context);
                              var cubit = DeleteCallbackCubit.get(context);
                              cubit.getDeleteReq();
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashBoardContactCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String lottiePath;
  final String buttonTitle;
  final double? height;
  final double? width;
  final BorderSide? borderSide;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final VoidCallback onPressed;

  const DashBoardContactCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.lottiePath,
    required this.buttonTitle,
    this.borderSide,
    this.buttonColor,
    this.buttonTextColor,
    required this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: MyColor.containerBGColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: MyColor.subtitleTextColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText(
            text: title,
            fontSize: 20.sp,
          ),
          SizedBox(height: 15.h),
          MyText(
            text: subtitle,
            fontWeight: FontWeight.w300,
            color: MyColor.subtitleTextColor,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(lottiePath, height: height ?? 50.h, width: width ?? 50.w),
              MyButton(
                fontSize: 14.sp,
                textColor: buttonTextColor,
                buttonColor: buttonColor,
                borderSide: borderSide,
                width: 100.w,
                height: 45.h,
                text: buttonTitle,
                onPressed: onPressed,
              )
            ],
          ),
        ],
      ),
    );
  }
}
