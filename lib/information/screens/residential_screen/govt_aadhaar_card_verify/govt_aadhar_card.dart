import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:salarynow/information/screens/residential_screen/residential_info_screen.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/utils/images.dart';
import 'package:salarynow/utils/keyboard_bottom_inset.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../../login/cubit/timer_cubit/timer_cubit.dart';
import '../../../../routing/route_path.dart';
import '../../../../utils/color.dart';
import '../../../../utils/on_screen_loader.dart';
import '../../../../utils/snackbar.dart';
import '../../../../utils/validation.dart';
import '../../../../utils/written_text.dart';
import '../../../../widgets/information_widgets/info_textfield_widget.dart';
import '../../../cubit/residential_cubit/aadhaar_card_otp/aadhaar_card_otp_cubit.dart';
import '../../../cubit/residential_cubit/aadhaar_card_verification/aadhaar_card_verification_cubit.dart';

class GovtAadhaarCardVerify extends StatefulWidget {
  final bool isApplyScreen;
  final bool isDashBoardScreen;
  const GovtAadhaarCardVerify({Key? key, required this.isDashBoardScreen, required this.isApplyScreen})
      : super(key: key);

  @override
  State<GovtAadhaarCardVerify> createState() => _GovtAadhaarCardVerifyState();
}

class _GovtAadhaarCardVerifyState extends State<GovtAadhaarCardVerify> {
  // ProfileCubit? profileCubit;
  final TextEditingController aadhaarCardController = TextEditingController();
  final TextEditingController pinPutController = TextEditingController();

  String otpNumber = '';
  String clientId = '';
  bool showOtpField = false;
  bool showSkipButton = false;

  final defaultPinTheme = PinTheme(
    margin: EdgeInsets.symmetric(horizontal: 5.w),
    width: 44.w,
    height: 60.h,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: MyColor.turcoiseColor),
    ),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    aadhaarCardController.dispose();
    pinPutController.dispose();
    // profileCubit?.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const InfoCustomAppBar(title: 'Aadhaar Verification'),
        body: MultiBlocListener(
          listeners: [
            /// aadhaar Otp Hit
            BlocListener<AadhaarCardOtpCubit, AadhaarCardOtpState>(
              listener: (context, state) {
                if (state is AadhaarCardOtpLoading) {
                  MyScreenLoader.onScreenLoader(context);
                }
                if (state is AadhaarCardOtpLoaded) {
                  Navigator.pop(context);

                  MySnackBar.showSnackBar(context, state.aadhaarOtpModal.responseMsg!);
                  showOtpField = true;

                  /// client Id
                  clientId = state.aadhaarOtpModal.responseData!.data!.clientId!;
                  setState(() {});
                  // MyDialogBox.aadhaarOtpDialog(
                  //     pinPutController: _pinPutController,
                  //     context: context,
                  //     clientID: state.aadhaarOtpModal.responseData!.data!.clientId!);
                }
                if (state is AadhaarCardOtpError) {
                  Navigator.pop(context);
                  MySnackBar.showSnackBar(context, state.error);
                  if (state.aadhaarOtpErrorModal?.responseApi != null) {
                    showSkipButton = state.aadhaarOtpErrorModal!.responseApi!;
                    showOtpField = false;
                    setState(() {});
                  }
                }
              },
            ),

            /// aadhaar Otp Verify

            BlocListener<AadhaarCardVerificationCubit, AadhaarCardVerificationState>(
              listener: (context, state) {
                if (state is AadhaarCardVerificationLoading) {
                  MyScreenLoader.onScreenLoader(context);
                }
                if (state is AadhaarCardVerificationLoaded) {
                  Navigator.pop(context);
                  if (widget.isApplyScreen == false) {
                    var cubit = ProfileCubit.get(context);
                    cubit.getProfile();
                  }

                  /// go to residential Screen
                  if (widget.isDashBoardScreen) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, RoutePath.residentialScreen);
                  }
                }
                if (state is AadhaarCardVerificationError) {
                  Navigator.pop(context);
                  MySnackBar.showSnackBar(context, state.error);
                }
              },
            ),
          ],
          child: GestureDetector(
            onTap: () => MyKeyboardInset.dismissKeyboard(context),
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // if (MyKeyboardInset.hideWidgetByKeyboard(context))
                    // Image.asset(
                    //   MyImages.aadhaarCardImage,
                    //   width: 150.w,
                    //   fit: BoxFit.fitWidth,
                    // ),
                    SizedBox(height: 30.h),
                    InfoTextFieldWidget(
                        textInputType: TextInputType.number,
                        // isPass: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          CardNumberFormatter(),
                        ],
                        title: 'Aadhaar Number/UIDAI',
                        hintText: MyWrittenText.enterAadhaarCardNumberText,
                        textEditingController: aadhaarCardController,
                        maxLength: 14,
                        onChanged: (value) {
                          if (value.length == 14) {
                            MyKeyboardInset.dismissKeyboard(context);
                            AadhaarCardOtpCubit.get(context).postAadhaarOtp(aadhaarCard: value.replaceAll(' ', ''));
                          } else {
                            /// remove controller
                            clientId = '';
                            otpNumber = '';
                            showOtpField = false;
                            pinPutController.clear();
                            showSkipButton = false;
                            setState(() {});
                          }
                        },
                        validator: (value) => InputValidation.aadhaarCard(value!)),
                    SizedBox(height: 20.h),
                    showOtpField == true
                        ? SizedBox(
                            height: 380.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const MyText(
                                        text: 'Please enter the OTP sent to your UIDAI-registered mobile number'),
                                    SizedBox(height: 20.h),
                                    Pinput(
                                      // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                      onCompleted: (value) {
                                        AadhaarCardVerificationCubit.get(context).postAadhaarVerification(
                                          clientID: clientId,
                                          otp: value,
                                        );
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
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],

                                      controller: pinPutController,
                                      // autofocus: true,
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
                                      autofocus: true,
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
                                                    AadhaarCardOtpCubit.get(context).postAadhaarOtp(
                                                        aadhaarCard: aadhaarCardController.text.replaceAll(' ', ''));
                                                    BlocProvider.of<TimerCubit>(context).restartTimer();
                                                  }
                                                },
                                                child: MyText(
                                                    text: '${MyWrittenText.resendOTPText} ',
                                                    color:
                                                        state == 0 ? MyColor.turcoiseColor : MyColor.subtitleTextColor,
                                                    fontSize: 15.sp),
                                              ),
                                              state == 0
                                                  ? const SizedBox()
                                                  : MyText(
                                                      text: '$state sec',
                                                      color: state == 0
                                                          ? MyColor.subtitleTextColor
                                                          : MyColor.turcoiseColor,
                                                      fontSize: 15.sp),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                MyButton(
                                    text: 'Confirm',
                                    onPressed: () {
                                      AadhaarCardVerificationCubit.get(context).postAadhaarVerification(
                                        clientID: clientId,
                                        otp: otpNumber,
                                      );
                                    })
                              ],
                            ),
                          )
                        : SizedBox(),
                    showSkipButton
                        ? MyButton(
                            text: 'SKIP',
                            onPressed: () {
                              if (widget.isDashBoardScreen) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushReplacementNamed(context, RoutePath.residentialScreen);
                              }
                            })
                        : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
