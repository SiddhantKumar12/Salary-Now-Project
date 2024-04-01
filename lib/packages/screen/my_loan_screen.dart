import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:salarynow/packages/screen/packages.dart';
import 'package:salarynow/repayment/cuibt/repayment/repayment_cubit.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import '../../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../../repayment/screen/previous_loan/pre_loan_web_view.dart';
import '../../repayment/screen/previous_loan/previous_loan.dart';
import '../../utils/color.dart';
import '../../utils/written_text.dart';
import '../../widgets/dashboard_widget/dashboard_list_tile.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/text_widget.dart';

class MyLoanScreen extends StatelessWidget {
  const MyLoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          var data = state.dashBoardModal;
          return getApplyScreen(data.responseData!.loanDetails!.loanstatus!)
              ? Scaffold(
                  appBar: const InfoCustomAppBar(
                    title: 'My Loans',
                    leading: true,
                    popScreen: false,
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          color: MyColor.whiteColor,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const MyText(text: MyWrittenText.applicationNoText),
                                  MyText(
                                    text: data.responseData!.loanDetails!.applicationNo!,
                                    color: MyColor.turcoiseColor,
                                  ),
                                ],
                              ),
                              const MyDivider(),
                              DashBoardListTileTwo(
                                title: MyWrittenText.appliedLoanText,
                                trailingTitle:
                                    "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(state.dashBoardModal.responseData!.loanDetails!.loanAmt!)}",
                              ),
                              DashBoardListTileTwo(
                                title: MyWrittenText.tenureText,
                                trailingTitle: "${data.responseData!.loanDetails!.tenure ?? ''} Days",
                              ),
                              SizedBox(height: 30.h),
                              MyButton(
                                  text: MyWrittenText.viewDetailsText,
                                  onPressed: () {
                                    var cubit = NavbarCubit.get(context);
                                    cubit.changeBottomNavBar(3);
                                  }),
                              SizedBox(height: 30.h),
                              BlocBuilder<RepaymentCubit, RepaymentState>(
                                builder: (context, state) {
                                  if (state is RepaymentLoadedState) {
                                    var data = state.loanChargesModal.responseData!.data;
                                    return Column(
                                      children: [
                                        data!.sanctionStatus == '1'
                                            ? Column(
                                                children: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          overlayColor: MaterialStateProperty.all(Colors.transparent)),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => PreLoanWebView(
                                                                      appBarTitle: 'Sanction Letter',
                                                                      url: state.loanChargesModal.responseData!.data!
                                                                          .sanctionUrl!,
                                                                    )));
                                                      },
                                                      child: const MyText(
                                                        text: MyWrittenText.viewSanctionText,
                                                        color: MyColor.turcoiseColor,
                                                      )),
                                                  Divider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                                ],
                                              )
                                            : const SizedBox(),
                                        data.agreementStatus == '1'
                                            ? Column(
                                                children: [
                                                  TextButton(
                                                      style: ButtonStyle(
                                                          overlayColor: MaterialStateProperty.all(Colors.transparent)),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => PreLoanWebView(
                                                                      appBarTitle: 'Loan Agreement',
                                                                      url: state.loanChargesModal.responseData!.data!
                                                                          .agreementUrl!,
                                                                    )));
                                                      },
                                                      child: const MyText(
                                                        text: MyWrittenText.viewAgreementText,
                                                        color: MyColor.turcoiseColor,
                                                      )),
                                                  Divider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                                ],
                                              )
                                            : const SizedBox(),
                                        (data.sanctionStatus == '1' || data.agreementStatus == '1')
                                            ? Column(
                                                children: [
                                                  MyText(
                                                    text: '(Password is your PAN No. in Block Letters)',
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14.sp,
                                                    color: MyColor.overdueButtonColor,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  Divider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              TextButton(
                                onPressed: () => Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => const PreviousLoanScreen())),
                                child: const MyText(
                                  text: "Go To Previous Loans",
                                  color: MyColor.turcoiseColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const PackagesScreen();
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColor.whiteColor,
            elevation: 0,
          ),
          body: MyErrorWidget(onPressed: () {
            var cubit = DashboardCubit.get(context);
            cubit.getDashBoardData();
          }),
        );
      },
    );
  }

  bool getApplyScreen(String value) {
    switch (value) {
      case '0':

        /// Pending
        return true;
      case '1':

        /// Approved
        return true;
      case '2':

        /// Disbursed
        return true;
      case '3':

        /// Close
        return false;
      case '4':

        /// Reject
        return false;
      case '5':

        /// Not Interested
        return false;

      case '7':
        return true;
      default:
        return false;
    }
  }
}
