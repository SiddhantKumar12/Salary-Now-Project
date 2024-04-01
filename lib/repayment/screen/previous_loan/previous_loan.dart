import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/repayment/cuibt/previous_loan/previous_loan_cubit.dart';
import 'package:salarynow/repayment/network/modal/repayment_modal.dart';
import 'package:salarynow/repayment/screen/previous_loan/pre_loan_web_view.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/widgets/divider_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../../utils/color.dart';
import '../../../../utils/written_text.dart';
import '../../../../widgets/dashboard_widget/dashboard_expansion_tile_widget.dart';
import '../../../utils/lottie.dart';
import '../../../widgets/dotted_border_widget.dart';

class PreviousLoanScreen extends StatelessWidget {
  const PreviousLoanScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(
        title: MyWrittenText.preLoanTitleText,
      ),
      body: BlocProvider(
        create: (context) => PreviousLoanCubit(),
        child: BlocBuilder<PreviousLoanCubit, PreviousLoanState>(
          builder: (context, state) {
            if (state is PreviousLoanLoaded) {
              var data = state.previousLoanModal.responseData;
              return data!.isEmpty
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        width: double.maxFinite,
                        height: 300.h,
                        child: MyDottedBorder(
                          color: MyColor.subtitleTextColor,
                          widget: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Lottie.asset(
                                MyLottie.boxEmptyLottie,
                                height: 230.h,
                                width: 200.w,
                              ),
                              const MyText(
                                text: MyWrittenText.noPreviousLoan,
                              ),
                            ],
                          )),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(left: 20.h, right: 20.h),
                                  color: MyColor.whiteColor,
                                  child: Column(
                                    children: [
                                      DashBoardExpansionTIle(
                                        title: "${data[index].loanNo} ",
                                        subtitle: 'Application No.',
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 5.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    MyText(text: 'Loan Amount', fontWeight: FontWeight.w300),
                                                    MyText(
                                                        text:
                                                            '${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data[index].loanAmount.toString())}',
                                                        fontWeight: FontWeight.w300),
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    MyText(text: 'Tenure', fontWeight: FontWeight.w300),
                                                    MyText(
                                                        text: "${data[index].approvedTeneur} Days",
                                                        fontWeight: FontWeight.w300),
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    MyText(text: 'Closed Date', fontWeight: FontWeight.w300),
                                                    MyText(
                                                        text: "${data[index].loanClosedDate} ",
                                                        fontWeight: FontWeight.w300),
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),
                                                Divider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                                data[index].sanctionUrl == "0"
                                                    ? SizedBox()
                                                    : Column(
                                                        children: [
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  overlayColor:
                                                                      MaterialStateProperty.all(Colors.transparent)),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => PreLoanWebView(
                                                                              appBarTitle: 'Sanction Letter',
                                                                              url: data[index].sanctionUrl!,
                                                                            )));
                                                              },
                                                              child: const MyText(
                                                                text: MyWrittenText.viewSanctionText,
                                                                color: MyColor.turcoiseColor,
                                                              )),
                                                          Divider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                                        ],
                                                      ),
                                                data[index].agreementUrl == "0"
                                                    ? SizedBox()
                                                    : Column(
                                                        children: [
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  overlayColor:
                                                                      MaterialStateProperty.all(Colors.transparent)),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => PreLoanWebView(
                                                                              appBarTitle: 'Loan Agreement',
                                                                              url: data[index].agreementUrl!,
                                                                            )));
                                                              },
                                                              child: const MyText(
                                                                text: MyWrittenText.viewAgreementText,
                                                                color: MyColor.turcoiseColor,
                                                              )),
                                                          Divider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                                          MyText(
                                                            text: '(Password is your PAN No. in Block Letters)',
                                                            textAlign: TextAlign.center,
                                                            fontSize: 14.sp,
                                                            color: MyColor.overdueButtonColor,
                                                            fontWeight: FontWeight.w300,
                                                          )
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      data.length == 1 ? SizedBox() : MyDivider()
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
            } else if (state is PreviousLoanLoading) {
              return MyLoader();
            } else {
              return MyErrorWidget(onPressed: () {
                var cubit = PreviousLoanCubit.get(context);
                cubit.getPreviousLoan();
              });
            }
          },
        ),
      ),
    );
  }
}
