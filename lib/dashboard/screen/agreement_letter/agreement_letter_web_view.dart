import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/micro_user_disclaimer/micro_user_disclaimer_cubit.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/micro_user_post_disclaimer/micro_user_post_disclaimer_cubit.dart';
import 'package:salarynow/dashboard/screen/agreement_letter/loan_agreement_screen.dart';
import 'package:salarynow/service_helper/api/api_strings.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../service_helper/web_view_contoller.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../../utils/color.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/loan_otp_agreement/loan_otp_agreement_cubit.dart';
import '../../network/modal/dashboard_modal.dart';
import '../micro_user_detail_screen/micro_family_detail_screen.dart';
import '../not_interested_screen/not_interested_screen.dart';

class AgreementLetterWebView extends StatefulWidget {
  final DashBoardModal dashBoardModal;

  const AgreementLetterWebView({super.key, required this.dashBoardModal});

  @override
  State<AgreementLetterWebView> createState() => _AgreementLetterWebViewState();
}

class _AgreementLetterWebViewState extends State<AgreementLetterWebView> {
  bool isLoading = true;
  late final WebViewController controller;
  LocalUserModal? localUserModal = MyStorage.getUserData();

  String agreementLetterUrl = '';

  bool isAgreeForAgreement = false;
  bool isDisclaimer = true;

  @override
  void initState() {
    super.initState();

    MicroUserDisclaimerCubit.get(context)
        .postMicroDisclaimer(loanId: widget.dashBoardModal.responseData!.loanDetails!.applyLoanDataId!);
    agreementLetterUrl =
        "${ApiStrings.baseUrl}${ApiStrings.loanAgreement}${localUserModal!.responseData!.userId}/${widget.dashBoardModal.responseData!.loanDetails!.applyLoanDataId}";
    controller = WebViewHelper.getWebView(
        url: agreementLetterUrl,
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: 'Loan Agreement'),
      body: BlocListener<MicroUserDisclaimerCubit, MicroUserDisclaimerState>(
        listener: (context, state) {
          if (state is MicroUserDisclaimerLoaded) {
            var data = state.modal.responseData;

            if (data!.isdialogshow! && data.microStatus!) {
              /// Dialog Box
              MyDialogBox.microUserDisclaimer(
                  loanId: widget.dashBoardModal.responseData!.loanDetails!.applyLoanDataId!,
                  context: context,
                  subtitle: state.modal.responseMsg!,
                  isDisclaimer: isDisclaimer);
            }
          }
        },
        child: BlocBuilder<MicroUserDisclaimerCubit, MicroUserDisclaimerState>(
          builder: (context, state) {
            if (state is MicroUserDisclaimerLoaded) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 8,
                          child: BlocListener<MicroUserPostDisclaimerCubit, MicroUserPostDisclaimerState>(
                            listener: (context, state) {
                              if (state is MicroUserPostDisclaimerLoading) {
                                MyScreenLoader.onScreenLoader(context);
                              }
                              if (state is MicroUserPostDisclaimerLoaded) {
                                Navigator.pop(context);
                                if (state.modal.responseData == "1") {
                                  Navigator.pop(context);

                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => MicroFamilyIncomeScreen()));
                                } else {
                                  /// A CONDITION HERE FOR REJECTION
                                  Navigator.pop(context);
                                  MyDialogBox.rbi90Days(context: context);
                                }
                              }
                              if (state is MicroUserPostDisclaimerError) {
                                Navigator.pop(context);
                                MySnackBar.showSnackBar(context, state.error);
                              }
                            },
                            child: WebViewWidget(
                              controller: controller,
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: MyColor.containerBGColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                                                value: isAgreeForAgreement,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isAgreeForAgreement = value!;
                                                  });
                                                },
                                              )),
                                        ),
                                      ),
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isAgreeForAgreement) {
                                              isAgreeForAgreement = false;
                                            } else {
                                              isAgreeForAgreement = true;
                                            }
                                            setState(() {});
                                          },
                                          child: MyText(
                                              text: MyWrittenText.acceptLoanAgreementLetter,
                                              color: MyColor.blackColor,
                                              fontSize: 15.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BlocListener<LoanAgreementOTPCubit, LoanAgreementOTPState>(
                                          listener: (context, state) {
                                            if (state is LoanAgreementOTPLoaded) {
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => LoanAgreementScreen(
                                                            dashBoardModal: widget.dashBoardModal,
                                                          )));
                                            }
                                            if (state is LoanAgreementLoading) {
                                              MyScreenLoader.onScreenLoader(context);
                                            }
                                            if (state is LoanAgreementOTPError) {
                                              Navigator.pop(context);
                                              MySnackBar.showSnackBar(context, state.error);
                                            }
                                          },
                                          child: MyButton(
                                            text: MyWrittenText.iAgreeText,
                                            onPressed: () {
                                              if (isAgreeForAgreement) {
                                                var loanOtpCubit = LoanAgreementOTPCubit.get(context);
                                                loanOtpCubit.getLoanAgreeOtp();
                                              } else {
                                                MySnackBar.showSnackBar(
                                                    context, 'Please accept the Terms and Conditions');
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: MyButton(
                                          text: MyWrittenText.notInterested,
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => NotInterestedScreen(
                                                        dashBoardModal: widget.dashBoardModal,
                                                      )),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  if (isLoading) const Center(child: MyLoader()),
                ],
              );
            } else if (state is MicroUserDisclaimerLoading) {
              return MyLoader();
            }
            return MyErrorWidget(onPressed: () {
              MicroUserDisclaimerCubit.get(context)
                  .postMicroDisclaimer(loanId: widget.dashBoardModal.responseData!.loanDetails!.applyLoanDataId!);
              agreementLetterUrl =
                  "${ApiStrings.baseUrl}${ApiStrings.loanAgreement}${localUserModal!.responseData!.userId}/${widget.dashBoardModal.responseData!.loanDetails!.applyLoanDataId}";
              controller = WebViewHelper.getWebView(
                  url: agreementLetterUrl,
                  onPageFinished: (url) {
                    setState(() {
                      isLoading = false;
                    });
                  });
            });
          },
        ),
      ),
    );
  }
}
