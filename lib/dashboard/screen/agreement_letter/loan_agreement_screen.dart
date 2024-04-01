import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:salarynow/dashboard/cubit/loan_verify_otp_agreement/loan_verify_otp_agree_cubit.dart';
import 'package:salarynow/dashboard/screen/e-mandate_screen/e-mandate_screen.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../login/cubit/timer_cubit/timer_cubit.dart';
import '../../../repayment/cuibt/repayment/repayment_cubit.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../cubit/dashboard_cubit/dashboard_cubit.dart';
import '../../cubit/loan_otp_agreement/loan_otp_agreement_cubit.dart';
import '../../network/modal/dashboard_modal.dart';

class LoanAgreementScreen extends StatelessWidget {
  final DashBoardModal dashBoardModal;

  LoanAgreementScreen({Key? key, required this.dashBoardModal}) : super(key: key);

  String otpNumber = "";
  LocalUserModal? localUserModal = MyStorage.getUserData();

  final TextEditingController _pinPutController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    var data = dashBoardModal.responseData!.loanDetails;
    int processingFess = int.parse(data!.pfee!) + int.parse(data.gstamt!);
    return Scaffold(
      appBar: const InfoCustomAppBar(title: MyWrittenText.loanAgreeText),
      body: BlocListener<LoanVerifyOtpAgreeCubit, LoanVerifyOtpAgreeState>(
        listener: (context, state) {
          if (state is LoanVerifyOtpAgreeLoading) {
            MyScreenLoader.onScreenLoader(context);
          }
          if (state is LoanVerifyOtpAgreeLoaded) {
            Navigator.pop(context);
            var dashboardCubit = DashboardCubit.get(context);
            dashboardCubit.getDashBoardData();
            var repaymentCubit = RepaymentCubit.get(context);
            repaymentCubit.getRepayment();
            MyDialogBox.proceedToEMandate(
                context: context,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EMandateScreen(dashBoardModal: dashBoardModal),
                      )).whenComplete(() {
                    Navigator.pop(context);
                  });
                });
          }
          if (state is LoanVerifyOtpAgreeError) {
            Navigator.pop(context);
            MySnackBar.showSnackBar(context, state.error);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const InfoTitleWidget(title: 'Loan Details', subtitle: ''),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    buildRowData(title: 'Loan Application Number', subtitle: data.applicationNo!),
                    buildRowData(title: 'Loan Amount', subtitle: "${MyWrittenText.rupeeSymbol} ${data.approvedAmt!}"),
                    buildRowData(title: 'Loan tenure', subtitle: "${data.approvedTeneur!} days"),
                    buildRowData(
                        title: 'Processing Fees',
                        subtitle: "${MyWrittenText.rupeeSymbol} ${processingFess.toString()} (including 18% GST)"),
                    buildRowData(
                        title: 'Interest Amount', subtitle: "${MyWrittenText.rupeeSymbol} ${data.interestAmt!}"),
                    buildRowData(
                        title: 'Loan Amount Payable', subtitle: "${MyWrittenText.rupeeSymbol} ${data.totalPayAmount!}"),
                    buildRowData(
                        title: 'Net Disbursal Amount',
                        subtitle: "${MyWrittenText.rupeeSymbol} ${data.disbursedAmount!}"),
                    buildRowData(
                        title: 'Late Payment Charges: ',
                        subtitle:
                            "(${data.latePaymentCharges})% per week in addition to the applicable interest charges."),
                  ],
                ),
                SizedBox(height: 15.h),
                MyText(
                  text: 'Please note that by entering the otp you agree to the above.',
                  fontSize: 18.sp,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.h),
                const MyText(
                  text: 'An OTP has been sent to your registered mobile number',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                ),
                SizedBox(height: 15.h),
                Pinput(
                  // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                  onCompleted: (value) {
                    context
                        .read<LoanVerifyOtpAgreeCubit>()
                        .verifyOtpLoan(mobileNumber: localUserModal!.responseData!.mobile!, otp: value.toString());
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
                //         .read<LoanVerifyOtpAgreeCubit>()
                //         .verifyOtpLoan(mobileNumber: localUserModal!.responseData!.mobile!, otp: value.toString());
                //   },
                //   fieldWidth: 40.w,
                //   fieldStyle: FieldStyle.underline,
                //   style: TextStyle(fontSize: 18.sp),
                //   onChanged: (value) {
                //     otpNumber = value;
                //   },
                // ),
                SizedBox(height: 25.h),
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
                                var loanOtpCubit = LoanAgreementOTPCubit.get(context);
                                loanOtpCubit.getLoanAgreeOtp();
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
                SizedBox(height: 30.h),
                MyButton(
                  width: 150.w,
                  text: 'Submit',
                  onPressed: () {
                    context
                        .read<LoanVerifyOtpAgreeCubit>()
                        .verifyOtpLoan(mobileNumber: localUserModal!.responseData!.mobile!, otp: otpNumber);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildRowData({required String title, required String subtitle}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MyText(text: title),
          ),
          Expanded(
            child: MyText(
              text: subtitle,
              // color: MyColor.blackColor,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
