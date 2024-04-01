import 'dart:io';
import 'dart:ui';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:salarynow/bottom_nav_bar/screen/bottom_nav.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/micro_user_post_disclaimer/micro_user_post_disclaimer_cubit.dart';
import 'package:salarynow/information/cubit/residential_cubit/aadhaar_card_verification/aadhaar_card_verification_cubit.dart';
import 'package:salarynow/information/screens/banking_screen/banking_info_screen.dart';
import 'package:salarynow/information/screens/personal_screen/personal_info_screen.dart';
import 'package:salarynow/information/screens/profession_screen/professional_info_screen.dart';
import 'package:salarynow/internet_connection/cubit/internet_cubit.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/required_document/screens/selfie_screen.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/information_widgets/info_textfield_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../dashboard/cubit/micro_user_cubit/update_micro_status/update_micro_status_cubit.dart';
import '../information/cubit/residential_cubit/aadhaar_card_otp/aadhaar_card_otp_cubit.dart';
import '../login/cubit/timer_cubit/timer_cubit.dart';
import '../profile/cubit/cancel_mandate/cancel_mandate_cubit.dart';
import '../routing/route_path.dart';
import '../utils/color.dart';
import '../utils/images.dart';
import '../utils/lottie.dart';
import '../utils/validation.dart';
import '../utils/written_text.dart';
import 'elevated_button_widget.dart';
import 'list_tile_widget.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class MyDialogBox {
  static permissionDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: MyImages.mailSvg,
        content: const MyText(text: MyWrittenText.allowPermissionText),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              MyWrittenText.denyText,
              style: TextStyle(color: MyColor.redColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              MyWrittenText.allowText,
              style: TextStyle(color: MyColor.greenColor),
            ),
          ),
        ],
      ),
    );
  }

  static successfulRegistration({required BuildContext context, required VoidCallback onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)), //this right here
              child: Padding(
                padding: EdgeInsets.only(bottom: 35.h, top: 20.h, left: 20.w, right: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      MyLottie.tickSuccessLottie,
                      height: 120.h,
                      width: 120.w,
                    ),
                    Column(
                      children: [
                        MyText(
                          text: 'Congratulations!',
                          color: MyColor.greenColor,
                          fontSize: 24.sp,
                        ),
                        SizedBox(height: 5.h),
                        MyText(
                          text: 'You have successfully registered',
                          fontSize: 20.sp,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    MyButton(fontSize: 18.sp, text: MyWrittenText.continueText, onPressed: onPressed)
                  ],
                ),
              ),
            ),
          );
        });
  }

  static successfulLoanDialogBox({required BuildContext context, required String userName, required String amount}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)), //this right here
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.h, top: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  MyLottie.tickSuccessLottie,
                  height: 120.h,
                  width: 120.w,
                ),
                Column(
                  children: [
                    MyText(
                      text: 'Successful',
                      fontSize: 26.sp,
                      color: MyColor.greenColor,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: MyText(
                        text: 'Dear $userName you have successfully applied for the loan amount of',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    MyText(
                      text: "${MyWrittenText.rupeeSymbol} $amount",
                      fontSize: 24.sp,
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                MyButton(
                    fontSize: 18.sp,
                    text: 'Go To Dashboard',
                    onPressed: () {
                      var botNavBarCubit = NavbarCubit.get(context);
                      botNavBarCubit.changeBottomNavBar(0);
                      Navigator.pushNamedAndRemoveUntil(context, RoutePath.botNavBar, (route) => false);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  static salarySlipDialogBox(
      {required BuildContext context,
      required String subTitle,
      required String textOnButton,
      required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)), //this right here
        child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                      )),
                ),
                SizedBox(height: 25.h),
                MyText(text: MyWrittenText.chooseOptionText, textAlign: TextAlign.center, fontSize: 24.sp),
                SizedBox(height: 10.h),
                MyListTile(
                  title: MyWrittenText.selectPdfText,
                  leading: const Icon(Icons.picture_as_pdf),
                  onTap: () {},
                ),
                MyListTile(
                  title: MyWrittenText.selectImageText,
                  leading: const Icon(Icons.image),
                  onTap: () {},
                ),
                Padding(padding: EdgeInsets.only(top: 50.h)),
                MyButton(text: textOnButton, onPressed: onPressed)
              ],
            ),
          ),
        ),
      ),
    );
  }

  static checkDocDialogBox({required BuildContext context, required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)), //this right here
            child: SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      var data = state.profileModal.responseData;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 40.sp,
                                  color: MyColor.redColor,
                                )),
                          ),
                          SizedBox(height: 25.h),
                          MyText(text: MyWrittenText.fillTheDetailText, textAlign: TextAlign.center, fontSize: 24.sp),
                          SizedBox(height: 10.h),
                          data?.selfi == true
                              ? MyListTile(
                                  title: MyWrittenText.selfieText,
                                  leading: Image.asset(
                                    MyImages.selfieImage,
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const SelfieScreen()));
                                  },
                                )
                              : const SizedBox(),
                          data?.personal == true
                              ? MyListTile(
                                  title: MyWrittenText.personalDetailText,
                                  leading: Image.asset(
                                    MyImages.personalImage,
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => PersonalInformationScreen()));
                                  },
                                )
                              : const SizedBox(),
                          data?.employeement == true
                              ? MyListTile(
                                  title: MyWrittenText.professionalDetailText,
                                  leading: Image.asset(
                                    MyImages.professionalImage,
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);

                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => ProfessionalInfoScreen()));
                                  },
                                )
                              : const SizedBox(),
                          data?.residential == true
                              ? MyListTile(
                                  title: MyWrittenText.residentialDetailText,
                                  leading: Image.asset(
                                    MyImages.residentImage,
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);

                                    if (data?.govtAadhar == true) {
                                      Navigator.pushNamed(context, RoutePath.govtAadhaarScreen, arguments: {
                                        'isApplyScreen': true,
                                        'isDashBoardScreen': false,
                                      });
                                    } else {
                                      Navigator.pushNamed(context, RoutePath.residentialScreen);
                                    }
                                    // Navigator.push(
                                    //     context, MaterialPageRoute(builder: (context) => ResidentialInfoScreen()));
                                  },
                                )
                              : const SizedBox(),
                          data?.bank == true
                              ? MyListTile(
                                  title: MyWrittenText.bankDetailsText,
                                  leading: Image.asset(
                                    MyImages.bankImage,
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => BankingInfoScreen()));
                                  },
                                )
                              : const SizedBox(),
                          SizedBox(height: 15.h),
                          MyButton(
                              text: MyWrittenText.cancelText,
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      );
                    } else {
                      return const MyLoader();
                    }
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  static loanAmountDialogBox({
    required BuildContext context,
    required Function(String) onSelected,
    required String maxAmount,
  }) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Form(
            key: formKey,
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoTextFieldWidget(
                    maxLength: maxAmount.length,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputType: TextInputType.phone,
                    textEditingController: controller,
                    title: 'Enter Amount',
                    hintText: 'Amount is in Rupees',
                    validator: (value) {
                      RegExp regExp = RegExp(r'^0.*');
                      if (value!.isNotEmpty) {
                        double newValue = double.parse(value);
                        if (newValue < 2000) {
                          return 'Enter amount above than 2000';
                        } else if (newValue > double.parse(maxAmount)) {
                          return 'Enter amount below than $maxAmount';
                        } else if (regExp.hasMatch(value)) {
                          return 'Enter Correct Amount';
                        } else {
                          return null;
                        }
                      } else {
                        return 'Enter Your amount ';
                      }
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: MyButton(
                    text: 'Confirm',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onSelected(controller.text.trim());
                        Navigator.of(context).pop();
                      } else {
                        // Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static alertCheckLoan({required BuildContext context, required String amount, required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: MyText(
            text: 'Are you sure ?',
            fontSize: 20.sp,
          ),
          content: MyText(text: 'You want ${MyWrittenText.rupeeSymbol} $amount'),
          actions: <Widget>[
            TextButton(
              child: const MyText(text: 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(onPressed: onPressed, child: const MyText(text: 'OK')),
          ],
        );
      },
    );
  }

  static openPermissionAppSetting(
      {required BuildContext context, required String error, required VoidCallback onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: MyText(
            text: error,
            fontSize: 20.sp,
          ),
          content: MyButton(text: 'Open App Settings', onPressed: onPressed),
        );
      },
    );
  }

  // Camera Selfie Permission

  static openSelfiePermissionAppSetting(
      {required BuildContext context, required String error, required VoidCallback onPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: MyText(
              text: error,
              fontSize: 20.sp,
            ),
            content: MyText(text: 'Open App Settings'),
            actions: <Widget>[
              TextButton(
                child: const MyText(text: 'Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(onPressed: onPressed, child: const MyText(text: 'OK')),
            ],
          ),
        );
      },
    );
  }

  // Permission Page Dialog box
  static showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: MyText(text: 'Are You Sure ?', fontSize: 20.sp),
          // content: Text('This is a rounded alert dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const MyText(text: 'No'),
            ),
            TextButton(
              onPressed: () {
                // call this to exit app
                FlutterExitApp.exitApp();
              },
              child: const MyText(text: 'Exit', color: MyColor.redColor),
            ),
          ],
        );
      },
    );
  }

  static void showDeleteReqCheckDialog({
    required BuildContext context,
    required final VoidCallback onTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: const MyText(text: 'Are you Sure ?'),
          content: const MyText(text: 'You want to delete your data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const MyText(text: 'No'),
            ),
            TextButton(
              onPressed: onTap,
              child: const MyText(text: 'Yes', color: MyColor.redColor),
            ),
          ],
        );
      },
    );
  }

  static void proceedToEMandate({required BuildContext context, required VoidCallback onPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            title: const MyText(
              text: 'Agreement signed successfully. please proceed to authorise',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 16.h), // Add some spacing
                MyButton(text: 'Proceed to E-Mandate', onPressed: onPressed)
              ],
            ),
          ),
        );
      },
    );
  }

  static void allPermissionDialogBox({
    required BuildContext context,
    required VoidCallback onPressed,
    required bool phone,
    required bool camera,
    // required bool contact,
    required bool sms,
    required bool location,
    // required bool storage
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: MyText(
            text: 'Give Permission',
            textAlign: TextAlign.center,
            fontSize: 20.sp,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  phone ? SizedBox() : MyText(text: 'Phone,'),
                  // contact ? SizedBox() : MyText(text: 'Contact, '),
                  sms ? SizedBox() : MyText(text: 'Sms, '),
                  camera ? SizedBox() : MyText(text: 'Camera, '),
                  // storage ? SizedBox() : MyText(text: 'Storage, '),
                  location ? SizedBox() : MyText(text: 'Location, '),
                ],
              ),
              SizedBox(height: 30.h), // Add some spacing
              MyButton(text: 'Open Settings', onPressed: onPressed)
            ],
          ),
        );
      },
    );
  }

  static void showDeleteReqResponseDialog(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: MyText(text: title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.h), // Add some spacing
              MyButton(text: 'Go Back', onPressed: () => Navigator.pop(context))
            ],
          ),
        );
      },
    );
  }

  static noInternetDialogBox(
    BuildContext context,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.connected) {
                // Navigator.pop(context);
              }
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyText(text: title),
                  SizedBox(height: 16.h), // Add some spacing
                  MyButton(text: 'Check Your Connection', onPressed: () => Navigator.pop(context))
                ],
              ),
            ),
          );
        });
      },
    );
  }

  static salaryConfirmation({
    required BuildContext context,
    required VoidCallback onPressed,
    required bool isNormalUser,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // insetPadding: EdgeInsets.symmetric(horizontal: 30.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              title: MyText(
                text: 'Salary Confirmation',
                textAlign: TextAlign.center,
                fontSize: 20.sp,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w, top: 8.h),
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                            ),
                            child: SizedBox(
                                height: 30.h,
                                width: 30.w,
                                child: Checkbox(
                                  value: isNormalUser,
                                  onChanged: (value) {
                                    setState(() {
                                      isNormalUser = value!;
                                    });
                                  },
                                )),
                          ),
                        ),
                      ),
                      Expanded(flex: 10, child: MyText(text: MyWrittenText.salaryCondition)),
                    ],
                  ),
                  SizedBox(height: 20.h), // Add some spacing
                  MyButton(
                      text: 'I Confirm',
                      onPressed: () {
                        var cubit = UpdateMicroStatusCubit.get(context);
                        cubit.postMicroStatus(microStatus: isNormalUser ? "1" : "0");
                      })
                ],
              ),
            );
          }),
        );
      },
    );
  }

  static microUserDisclaimer({
    required BuildContext context,
    required bool isDisclaimer,
    required String subtitle,
    required String loanId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // insetPadding: EdgeInsets.symmetric(horizontal: 30.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 12.w,
                          ),
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                            ),
                            child: SizedBox(
                                height: 30.h,
                                width: 30.w,
                                child: Checkbox(
                                  value: isDisclaimer,
                                  onChanged: (value) {
                                    setState(() {
                                      isDisclaimer = value!;
                                    });
                                  },
                                )),
                          ),
                        ),
                      ),
                      Expanded(flex: 10, child: MyText(text: subtitle)),
                    ],
                  ),
                  SizedBox(height: 20.h), // Add some spacing
                  MyButton(
                      // width: 150.w,
                      text: 'I Confirm',
                      onPressed: () {
                        MicroUserPostDisclaimerCubit.get(context)
                            .postMicroDisclaimer(loanId: loanId, checkStatus: isDisclaimer ? '1' : '0');
                      })
                ],
              ),
            );
          }),
        );
      },
    );
  }

  static launguageDialogBox({
    required BuildContext context,
    required bool isLanguage,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyText(
                    text: MyWrittenText.engLanguageSubtitle,
                    fontSize: 15.sp,
                  ),
                  SizedBox(height: 16.h), // Add some spacing
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: MyColor.whiteColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                                ),
                                child: SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      value: isLanguage,
                                      onChanged: (value) {
                                        setState(() {
                                          isLanguage = value!;
                                        });
                                      },
                                    )),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            MyText(
                              text: 'I agree with the above',
                              color: MyColor.blackColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                text: MyWrittenText.denyText,
                                onPressed: () {
                                  FlutterExitApp.exitApp();
                                },
                                borderSide: BorderSide(color: MyColor.subtitleTextColor),
                                buttonColor: MyColor.whiteColor,
                                textColor: MyColor.subtitleTextColor,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                                child: MyButton(
                                    text: MyWrittenText.iAgreeText,
                                    onPressed: () {
                                      if (isLanguage) {
                                        Navigator.pop(context);
                                      } else {
                                        MySnackBar.showSnackBar(context, 'Please Accept Launguage');
                                      }
                                    })),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  static rbi90Days({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                MyText(text: MyWrittenText.rbiGuideline),
                SizedBox(height: 20.h),
                MyButton(
                    text: 'OK',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
                        (route) => false,
                      );
                    }),
              ]),
            );
          }),
        );
      },
    );
  }

  static faqDialogBox({
    required BuildContext context,
    required String title,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            title: MyText(text: 'Dear $title', fontSize: 24.sp),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              MyText(text: MyWrittenText.faqDialogSubtitle),
              SizedBox(height: 20.h),
              MyButton(
                  text: 'Close',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ]),
          );
        });
      },
    );
  }

  void checkDebugging({
    required BuildContext context,
    required bool debugging,
    // required bool realDevice,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                MyText(
                  text: MyWrittenText.sorry,
                  fontSize: 24.sp,
                ),
                SizedBox(height: 20.h),
                MyText(
                  text: MyWrittenText.disable,
                  fontSize: 18.sp,
                  color: MyColor.subtitleTextColor,
                ),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const MyText(
                      text: MyWrittenText.debugging,
                    ),
                    trailing: !debugging
                        ? const Icon(Icons.done, color: MyColor.greenColor)
                        : const Icon(Icons.warning_amber, color: MyColor.redColor)),
                // ListTile(
                //     contentPadding: EdgeInsets.zero,
                //     title: const MyText(
                //       text: MyWrittenText.realDevice,
                //     ),
                //     trailing: realDevice
                //         ? const Icon(Icons.done, color: MyColor.greenColor)
                //         : const Icon(Icons.close, color: MyColor.redColor)),
                SizedBox(height: 20.h),
                MyButton(
                    text: 'Go To Settings',
                    onPressed: () {
                      AppSettings.openDevelopmentSettings();
                    }),
              ]),
            );
          }),
        );
      },
    );
  }

  static aadhaarOtpDialog({
    required BuildContext context,
    required String clientID,
    required TextEditingController pinPutController,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          String otpNumber = '';
          final defaultPinTheme = PinTheme(
            width: 56.w,
            height: 56.h,
            textStyle: const TextStyle(
              fontSize: 22,
              color: Color.fromRGBO(30, 60, 87, 1),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: MyColor.turcoiseColor),
            ),
          );
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            title: MyText(
              text: 'Enter Your Aadhaar OTP',
              fontSize: 24.sp,
              textAlign: TextAlign.center,
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Pinput(
                // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                onCompleted: (value) {
                  AadhaarCardVerificationCubit.get(context).postAadhaarVerification(clientID: clientID, otp: value);
                },
                onChanged: (value) {
                  otpNumber = value;
                },
                length: 6,
                // onSubmitted: (String pin) {
                //   context
                //       .read<LoginCubit>()
                //       .verifyUser(mobileNumber: widget.mobileNumber, otp: pin.toString());
                // },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                controller: pinPutController,
                autofocus: true,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: MyColor.turcoiseColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    // color: fillColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: MyColor.turcoiseColor),
                  ),
                ),
                defaultPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: MyColor.subtitleTextColor.withOpacity(0.3),
                    // color: fillColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: MyColor.subtitleTextColor.withOpacity(0.3)),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 20.h),
              BlocProvider(
                create: (context) => TimerCubit()..startTimer(),
                child: BlocBuilder<TimerCubit, int>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (state == 0) {
                              AadhaarCardOtpCubit.get(context).postAadhaarOtp(aadhaarCard: otpNumber);
                              BlocProvider.of<TimerCubit>(context).restartTimer();
                            }
                          },
                          child: MyText(
                              text: '${MyWrittenText.resendOTPText} ',
                              color: state == 0 ? MyColor.turcoiseColor : MyColor.subtitleTextColor,
                              fontSize: 15.sp),
                        ),
                        state == 0
                            ? const SizedBox()
                            : MyText(
                                text: '$state sec',
                                color: state == 0 ? MyColor.subtitleTextColor : MyColor.turcoiseColor,
                                fontSize: 15.sp),
                      ],
                    );
                  },
                ),
              ),
            ]),
          );
        });
      },
    );
  }

  static appUpdateDialogBox({
    required BuildContext context,
    required String appVersion,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            MyImages.appIcon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      // border: Border.all(color: MyColor.turcoiseColor),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: MyText(
                    text: 'Version $appVersion',
                    color: MyColor.subtitleTextColor,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 15.h),
                MyText(
                  text: MyWrittenText.newUpdate,
                  color: MyColor.turcoiseColor,
                  fontSize: 20.sp,
                ),
                SizedBox(height: 20.h),
                MyText(
                  text: MyWrittenText.newUpdateSubtitle,
                  textAlign: TextAlign.center,
                  color: MyColor.subtitleTextColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
                SizedBox(height: 40.h),
                MyButton(
                    text: 'UPDATE NOW',
                    onPressed: () {
                      final playStoreUri = Uri.parse(MyWrittenText.playStoreAppUrl);
                      launchUrl(
                        playStoreUri,
                        mode: LaunchMode.externalApplication,
                      );
                      // Navigator.pop(context);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  static cancelMandate({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              const MyText(
                text: 'Your loan is currently active please close it first in order to cancel your e-mandate',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              MyButton(
                  text: 'OK',
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]),
          );
        });
      },
    );
  }

  static remarksCancelMandate(
      {required BuildContext context,
      required TextEditingController textEditingController,
      CancelMandateCubit? cancelMandateCubit,
      required String loanNumber
      // required VoidCallback onPressed,
      }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            content: Form(
              key: formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(text: 'Remarks', fontSize: 24.sp),
                    InfoTextFieldWidget(
                      title: '',
                      textEditingController: textEditingController,
                      hintText: 'Enter your remarks',
                      validator: (value) => InputValidation.notEmpty(value!),
                    ),
                    SizedBox(height: 40.h),
                    MyButton(
                        text: 'Confirm',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            cancelMandateCubit?.postCancelMandate(remarks: "remarks", loanNo: loanNumber);
                            textEditingController.clear();
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
