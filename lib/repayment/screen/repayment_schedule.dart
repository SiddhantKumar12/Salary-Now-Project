import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/repayment/network/modal/loan_charges_modal.dart';
import 'package:salarynow/widgets/divider_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../utils/color.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/dashboard_widget/dashboard_expansion_tile_widget.dart';
import '../../utils/money_seperator.dart';

class RepaymentScheduleScreen extends StatelessWidget {
  final LoanChargesModal loanChargesModal;
  const RepaymentScheduleScreen({Key? key, required this.loanChargesModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: MyWrittenText.repaymentScheduleText),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: loanChargesModal.responseData?.emidata?.length,
                itemBuilder: (context, index) {
                  var data = loanChargesModal.responseData?.emidata;
                  return Container(
                    padding: EdgeInsets.only(
                      left: 15.h,
                      right: 15.h,
                    ),
                    color: MyColor.whiteColor,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            DashBoardExpansionTIle(
                              title:
                                  "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data?[index].amount.toString() ?? '')}",
                              subtitle: data?[index].duedate ?? '',
                              titleColor:
                                  int.parse(data![index].overdue.toString()) > 0 ? MyColor.subtitleTextColor : null,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const MyText(text: 'Actual EMI Amount', fontWeight: FontWeight.w300),
                                        MyText(
                                            text:
                                                '${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data[index].emiFixed.toString())}',
                                            fontWeight: FontWeight.w300),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    // loanChargesModal.responseData!.chargesShow == true
                                    //     ? Column(
                                    //         children: [
                                    //           Row(
                                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //             children: [
                                    //               MyText(text: 'Penal Interest', fontWeight: FontWeight.w300),
                                    //               MyText(
                                    //                   text:
                                    //                       '${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data?[index].penalBalanceAmount.toString() ?? '')}',
                                    //                   fontWeight: FontWeight.w300),
                                    //             ],
                                    //           ),
                                    //           SizedBox(height: 5.h),
                                    //           Row(
                                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //             children: [
                                    //               MyText(text: 'Overdue Interest', fontWeight: FontWeight.w300),
                                    //               MyText(
                                    //                   text:
                                    //                       '${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data?[index].overdueBalanceAmount.toString() ?? '')}',
                                    //                   fontWeight: FontWeight.w300),
                                    //             ],
                                    //           ),
                                    //           SizedBox(height: 5.h),
                                    //           Row(
                                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //             children: [
                                    //               MyText(text: 'Bounce Charges', fontWeight: FontWeight.w300),
                                    //               MyText(
                                    //                   text:
                                    //                       '${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data?[index].bounceCharge.toString() ?? '')}',
                                    //                   fontWeight: FontWeight.w300),
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       )
                                    //     : Row(
                                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           MyText(text: 'Other Charges', fontWeight: FontWeight.w300),
                                    //           MyText(
                                    //               text:
                                    //                   '${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data[index].otherCharge.toString() ?? '')}',
                                    //               fontWeight: FontWeight.w300),
                                    //         ],
                                    //       ),
                                    // SizedBox(height: 5.h),
                                    // data[index].overdue.toString() == "0"
                                    //     ? SizedBox()
                                    //     : Row(
                                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           MyText(text: 'Overdue Days', fontWeight: FontWeight.w300),
                                    //           MyText(
                                    //               text: '${data[index].overdue.toString() ?? ''}',
                                    //               fontWeight: FontWeight.w300),
                                    //         ],
                                    //       ),
                                  ]),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(-0.w, 30.h),
                              child: Align(
                                alignment: Alignment.center,
                                child: showContainer(data, index),
                              ),
                            )
                          ],
                        ),
                        MyDivider()
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Container buildContainer({
    required Color color,
    required String text,
    required Color textColor,
    required double width,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          )),
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Center(
          child: MyText(
            text: text,
            color: textColor,
            // fontWeight: FontWeight.w300,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Container showContainer(List<Emidata> data, int index) {
    String? status = data[index].status;
    String? overDue = data[index].overdue.toString();
    Container showStatus = Container();
    if (status == '0') {
      if (overDue == '1') {
        showStatus = buildContainer(
            color: MyColor.overdueColor, width: 90.w, text: 'Overdue', textColor: MyColor.overdueButtonColor);
      } else {
        showStatus = Container();
      }
    } else if (status == '1') {
      showStatus = buildContainer(
          color: MyColor.partialPayBGColor, width: 160.w, text: 'Partial Payment', textColor: MyColor.partialPayColor);
    } else if (status == '2') {
      showStatus = buildContainer(color: MyColor.paidBgColor, width: 90.w, text: 'Paid', textColor: MyColor.paidColor);
    } else {
      showStatus = Container();
    }
    return showStatus;
  }
}
