import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:salarynow/login/cubit/login_cubit.dart';
import 'package:salarynow/login/cubit/timer_cubit/timer_cubit.dart';
import 'package:salarynow/storage/local_storage.dart';
import 'package:salarynow/storage/local_storage_strings.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../utils/color.dart';
import '../../permission_handler/cubit/all_permission_cubit/permission_cubit.dart';
import '../../routing/route_path.dart';
import '../../utils/keyboard_bottom_inset.dart';
import '../../utils/snackbar.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/logo_image_widget.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String imei;

  const OtpScreen({
    Key? key,
    this.mobileNumber = "",
    this.imei = "",
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  String otpNumber = "";

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: MyColor.turcoiseColor),
    ),
  );

  // String _commingSms = 'Unknown';

  // Future<void> initSmsListener() async {
  //   String? commingSms;
  //   try {
  //     commingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     commingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _commingSms = commingSms!;
  //     print(_commingSms);
  //
  //     _pinPutController.text = extractOTP(_commingSms);
  //   });
  // }

  // String extractOTP(String message) {
  //   RegExp regExp = RegExp(r'\b\d{6}\b'); // Regular expression to match a 6-digit number.
  //   RegExpMatch? match = regExp.firstMatch(message); // Use nullable RegExpMatch.
  //
  //   if (match != null) {
  //     return match.group(0) ?? ""; // Use null-aware operator (??) to handle null group.
  //   }
  //   return "";
  // }

  @override
  void initState() {
    super.initState();
    // initSmsListener();
    var permissionCubit = PermissionCubit.get(context);
    permissionCubit.reqSMSPermission();
  }

  @override
  void dispose() {
    super.dispose();
    // AltSmsAutofill().unregisterListener();

    _pinPutController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is OtpErrorState) {
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, state.error.toString());
        }
        if (state is OtpLoadingState) {
          MyScreenLoader.onScreenLoader(context);
        }
        if (state is OtpLoadedState) {
          Navigator.pop(context);

          /// Response 0 is for New User and 1 for the Login user
          if (state.loginVerifyModal.responseStatus == 0) {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutePath.registrationScreen, arguments: widget.mobileNumber, (route) => false);
          } else {
            MyStorage.writeData(MyStorageString.userLoggedIn, true);
            Navigator.pushNamedAndRemoveUntil(context, RoutePath.botNavBar, (route) => false);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
            child: Column(
              children: [
                if (MyKeyboardInset.hideWidgetByKeyboard(context)) const Center(child: MyLogoImageWidget()),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 400.h,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: MyColor.subtitleTextColor.withOpacity(0.2), //New
                        blurRadius: 10.0,
                      )
                    ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                  text: MyWrittenText.verifyNumberText, color: MyColor.titleTextColor, fontSize: 30.sp),
                              SizedBox(height: 5.h),
                              Wrap(
                                children: [
                                  MyText(
                                      text: '${MyWrittenText.sixDigitOTPText} ',
                                      color: MyColor.subtitleTextColor,
                                      fontSize: 16.sp),
                                  MyText(
                                      text: '+91 ${widget.mobileNumber}',
                                      color: MyColor.subtitleTextColor,
                                      fontSize: 16.sp),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // OTPTextField(
                        //   inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                        //   length: 6,
                        //   outlineBorderRadius: 10.r,
                        //   margin: EdgeInsets.symmetric(horizontal: 2.w),
                        //   contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        //   keyboardType: TextInputType.number,
                        //   width: MediaQuery.of(context).size.width,
                        //   textFieldAlignment: MainAxisAlignment.spaceAround,
                        //   otpFieldStyle: OtpFieldStyle(
                        //     enabledBorderColor: Colors.black,
                        //     focusBorderColor: Colors.black,
                        //     borderColor: Colors.black,
                        //     // backgroundColor: Colors.purple.shade50,
                        //   ),
                        //   onCompleted: (value) {
                        //     context
                        //         .read<LoginCubit>()
                        //         .verifyUser(mobileNumber: widget.mobileNumber, otp: value.toString());
                        //   },
                        //   fieldWidth: 40.w,
                        //   fieldStyle: FieldStyle.underline,
                        //   style: TextStyle(fontSize: 18.sp),
                        //   onChanged: (value) {
                        //     otpNumber = value;
                        //   },
                        // ),
                        Pinput(
                          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                          onCompleted: (value) {
                            context
                                .read<LoginCubit>()
                                .verifyUser(mobileNumber: widget.mobileNumber, otp: value.toString());
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

                          controller: _pinPutController,
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
                        Transform.translate(
                          offset: Offset(0, -10.h),
                          child: BlocProvider(
                            create: (context) => TimerCubit()..startTimer(),
                            child: BlocBuilder<TimerCubit, int>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (state == 0) {
                                          // initSmsListener();
                                          context.read<LoginCubit>().loginUser(
                                              mobileNumber: widget.mobileNumber, imei: widget.imei, isLoginPage: false);
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
                        ),
                        Column(
                          children: [
                            MyButton(
                                text: MyWrittenText.verifyText,
                                onPressed: () {
                                  if (otpNumber.isNotEmpty) {
                                    context
                                        .read<LoginCubit>()
                                        .verifyUser(mobileNumber: widget.mobileNumber, otp: otpNumber);
                                  } else {
                                    MySnackBar.showSnackBar(context, 'Please Enter OTP');
                                  }
                                }),
                            SizedBox(height: 15.h),
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: MyText(
                                    text: MyWrittenText.changeNumberText,
                                    color: MyColor.turcoiseColor,
                                    fontSize: 15.sp)),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
