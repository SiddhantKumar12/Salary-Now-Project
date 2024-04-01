import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import '../../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/dashboard_widget/dashboard_list_tile.dart';
import '../network/modal/dashboard_modal.dart';

class DashBoardDisbursedScreen extends StatelessWidget {
  final DashBoardModal dashBoardModal;

  const DashBoardDisbursedScreen({Key? key, required this.dashBoardModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = dashBoardModal.responseData!.loanDetails;
    return Column(
      children: [
        Container(
          color: MyColor.containerBGColor,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              DashBoardListTileTwo(
                title: MyWrittenText.loanStatusText,
                trailingWidget: Container(
                  decoration: BoxDecoration(
                    color: data?.loanstatus! == '7' ? Colors.blue : MyColor.greenColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      var cubit = NavbarCubit.get(context);
                      cubit.changeBottomNavBar(3);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          data?.loanstatus! == '2'
                              ? Icon(Icons.done, size: 25.sp, color: MyColor.whiteColor)
                              : SizedBox(),
                          SizedBox(width: 3.w),
                          MyText(
                            text: data?.statusMessage?.toUpperCase() ?? '',
                            fontSize: 14.sp,
                            color: MyColor.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                trailingColor: MyColor.greenColor,
              ),
              const MyDivider(),
              DashBoardListTileTwo(
                title: MyWrittenText.applicationNoText,
                trailingTitle: "${data?.applicationNo}",
              ),
              DashBoardListTileTwo(
                title: MyWrittenText.approvedLoanText,
                trailingTitle: "₹ ${IndianMoneySeperator.formatAmount(data?.approvedAmt ?? '')}",
              ),
              DashBoardListTileTwo(
                title: MyWrittenText.appliedDateText,
                trailingTitle: "${data?.createdDate!.substring(0, 10)}",
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
              MyButton(
                text: MyWrittenText.loanDetails,
                onPressed: () {
                  var cubit = NavbarCubit.get(context);
                  cubit.changeBottomNavBar(3);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
