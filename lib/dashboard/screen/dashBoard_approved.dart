import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/screen/agreement_letter/agreement_letter_web_view.dart';
import 'package:salarynow/dashboard/screen/mandate_video_webView/mandate_video_screen.dart';
import 'package:salarynow/dashboard/screen/sanction_letter/sanction_letter_webView.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import '../../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/dashboard_widget/dashboard_list_tile.dart';
import '../../widgets/text_widget.dart';
import '../network/modal/dashboard_modal.dart';
import 'e-mandate_screen/e-mandate_screen.dart';

class DashBoardApprovedScreen extends StatelessWidget {
  final DashBoardModal dashBoardModal;

  const DashBoardApprovedScreen({Key? key, required this.dashBoardModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = dashBoardModal.responseData?.loanDetails;
    var data2 = dashBoardModal.responseData;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.h, bottom: 20.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: MyColor.containerBGColor,
                child: Column(
                  children: [
                    DashBoardListTileTwo(
                      title: MyWrittenText.loanStatusText,
                      trailingWidget: Container(
                        decoration: BoxDecoration(
                          color: MyColor.greenColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            var cubit = NavbarCubit.get(context);
                            cubit.changeBottomNavBar(3);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
                            child: MyText(
                                text: data?.statusMessage?.toUpperCase() ?? '',
                                fontSize: 14.sp,
                                color: MyColor.whiteColor),
                          ),
                        ),
                      ),
                    ),
                    const MyDivider(),
                    DashBoardListTileTwo(
                      title: MyWrittenText.applicationNumberText,
                      trailingTitle: data?.applicationNo!,
                    ),
                    DashBoardListTileTwo(
                      title: MyWrittenText.approvedLoanText,
                      trailingTitle: "₹ ${IndianMoneySeperator.formatAmount(data?.approvedAmt ?? '')}",
                    ),
                    DashBoardListTileTwo(
                      title: MyWrittenText.appliedDateText,
                      trailingTitle: data?.createdDate?.substring(0, 10) ?? '',
                    ),
                    DashBoardListTileTwo(
                      title: MyWrittenText.tenureText,
                      trailingTitle: "${data?.tenure} Days",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.maxFinite,
                color: MyColor.whiteColor,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    data2!.sanctionStatus == "0"
                        ? MyButton(
                            text: MyWrittenText.sanctionText,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SanctionLetterWebView(dashBoardModal: dashBoardModal)));
                            },
                          )
                        : data2.agreementStatus == "0"
                            ? Column(
                                children: [
                                  MyButton(
                                    text: MyWrittenText.loanAgreeText,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AgreementLetterWebView(dashBoardModal: dashBoardModal)));
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  TextButton(
                                    child: const MyText(
                                      text: 'How to sign agreement and e-mandate',
                                      textDecoration: TextDecoration.underline,
                                    ),
                                    onPressed: () {
                                      // Navigate to video page
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => const EMandateVideo()));
                                    },
                                  )
                                ],
                              )
                            : data2.mandatestatus == false
                                ? Column(
                                    children: [
                                      MyButton(
                                        text: MyWrittenText.eMandateText,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => EMandateScreen(
                                                        dashBoardModal: dashBoardModal,
                                                      )));
                                        },
                                      ),
                                      SizedBox(height: 10.h),
                                      TextButton(
                                        child: const MyText(
                                          text: 'How to sign agreement and e-mandate',
                                        ),
                                        onPressed: () {
                                          // Navigate to video page
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => const EMandateVideo()));
                                        },
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
