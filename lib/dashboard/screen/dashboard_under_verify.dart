import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/bottom_nav_bar/cubit/navbar_cubit.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../routing/route_path.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/dashboard_widget/dashboard_list_tile.dart';

class DashBoardUnderVerifyWidget extends StatelessWidget {
  final DashBoardModal dashBoardModal;

  const DashBoardUnderVerifyWidget({Key? key, required this.dashBoardModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = dashBoardModal.responseData?.loanDetails;
    return Column(
      children: [
        Container(
          color: MyColor.containerBGColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DashBoardListTileTwo(
                title: MyWrittenText.loanStatusText,
                trailingWidget: Container(
                  decoration: BoxDecoration(
                    color: data!.status == '3' ? MyColor.primaryBlueColor : MyColor.warningYellowColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      var cubit = NavbarCubit.get(context);
                      cubit.changeBottomNavBar(2);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
                      child: MyText(
                        text: data.statusMessage?.toUpperCase() ?? '',
                        fontSize: 14.sp,
                        color: data.status == '3' ? MyColor.whiteColor : MyColor.blackColor,
                      ),
                    ),
                  ),
                ),
              ),
              const MyDivider(),
              DashBoardListTileTwo(
                title: MyWrittenText.applicationNumberText,
                trailingTitle: data.applicationNo!,
              ),
              DashBoardListTileTwo(
                title: MyWrittenText.appliedLoanText,
                trailingTitle: "₹ ${IndianMoneySeperator.formatAmount(data.approvedAmt!)}",
              ),
              DashBoardListTileTwo(
                title: MyWrittenText.appliedDateText,
                trailingTitle: data.createdDate!.substring(0, 10),
              ),
              DashBoardListTileTwo(
                title: MyWrittenText.appliedTenureText,
                trailingTitle: "${data.tenure!} Days",
              ),
              SizedBox(height: 30.h),
              // MyButton(text: 'Submit Your Document', onPressed: () {}),
            ],
          ),
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              var data = state.profileModal.responseData;
              if (data!.idproofverify == true ||
                  data.pancardFileverify == true ||
                  data.addressProofVerify == true ||
                  data.bankVerify == true) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.reqDocumentScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: MyColor.overdueColor,
                      border: Border.all(color: MyColor.overdueButtonColor),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: "* ",
                                      color: MyColor.redColor,
                                      fontSize: 14.sp,
                                    ),
                                    Flexible(
                                      child: MyText(
                                        text: "Please submit your pending Document",
                                        // textAlign: TextAlign.justify,
                                        color: MyColor.redColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.upload,
                              color: MyColor.turcoiseColor,
                              size: 30.sp,
                            )
                            // MyButton(
                            //   // buttonColor: MyColor.overdueButtonColor,
                            //   // height: 35.h,
                            //   text: 'UPLOAD', fontSize: 15.sp, textAlign: TextAlign.center,
                            //   textColor: MyColor.whiteColor,
                            //   onPressed: () => Navigator.push(
                            //       context, MaterialPageRoute(builder: (context) => const ReqDocumentScreen())),
                            // ),
                            )
                      ],
                    ),
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
        SizedBox(height: 15.h),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              var data = state.profileModal.responseData;
              if (data!.govtAadhar == true) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.govtAadhaarScreen, arguments: {
                      'isApplyScreen': false,
                      'isDashBoardScreen': true,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: MyColor.overdueColor,
                      border: Border.all(color: MyColor.overdueButtonColor),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "* ",
                                  color: MyColor.redColor,
                                  fontSize: 14.sp,
                                ),
                                Flexible(
                                  child: MyText(
                                    text: "Please Verify your Aadhaar",
                                    // textAlign: TextAlign.justify,
                                    color: MyColor.redColor,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 28.sp,
                              color: MyColor.turcoiseColor,
                            ))
                      ],
                    ),
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
