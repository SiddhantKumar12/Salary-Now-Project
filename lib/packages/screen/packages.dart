import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/bottom_nav_bar/cubit/navbar_cubit.dart';
import 'package:salarynow/packages/cubit/packages_cubit/packages_cubit.dart';
import 'package:salarynow/packages/screen/loan_amount_screen.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/divider_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../utils/color.dart';
import '../../splash_screen/screen/splash_screen.dart';
import '../../storage/local_storage.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(
        leading: true,
        popScreen: false,
        title: MyWrittenText.productText,
      ),
      body: BlocListener<PackagesCubit, PackagesState>(
        listener: (context, state) {
          if (state is PackagesErrorState) {
            if (state.error == MyWrittenText.unauthorizedAccess) {
              MyStorage.cleanAllLocalStorage();
              FlutterExitApp.exitApp();
            }
          }
        },
        child: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            if (state is PackagesLoadedState) {
              return Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: RefreshIndicator(
                  onRefresh: () {
                    var cubit = PackagesCubit.get(context);
                    return cubit.getPackages();
                  },
                  child: ListView(
                    children: [
                      SizedBox(height: 20.h),
                      const InfoTitleWidget(
                        title: MyWrittenText.avaLoanTitleText,
                        subtitle: MyWrittenText.avaLoanSubTitleText,
                      ),
                      SizedBox(height: 25.h),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.modal.responseData!.length,
                          itemBuilder: (context, index) {
                            var data = state.modal.responseData;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return LoanAmountScreen(
                                    maxAmount: data[index].maxAmount!,
                                    productId: data[index].id!,
                                  );
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                    color: MyColor.subtitleTextColor,
                                  ),
                                  color: MyColor.whiteColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                            text: data![index].productName!,
                                            fontSize: 20.sp,
                                          ),
                                          MyButton(
                                            height: 35.h,
                                            width: 100.w,
                                            text: MyWrittenText.selectText,
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return LoanAmountScreen(
                                                  maxAmount: data[index].maxAmount!,
                                                  productId: data[index].id!,
                                                );
                                              }));
                                            },
                                          ),
                                        ],
                                      ),
                                      MyDivider(color: MyColor.subtitleTextColor.withOpacity(0.4)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(text: "${data[index].days!} DAYS", fontSize: 18.sp),
                                              MyText(
                                                text: MyWrittenText.durationText,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              MyText(
                                                  text:
                                                      "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data[index].maxAmount!)}",
                                                  fontSize: 18.sp),
                                              MyText(
                                                text: MyWrittenText.maxAmountText,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      MyDivider(color: MyColor.subtitleTextColor.withOpacity(0.4)),
                                      MyText(
                                        text: data[index].productDescription!,
                                        fontWeight: FontWeight.w300,
                                        wordSpacing: 0.2,
                                        fontSize: 14.sp,
                                      ),
                                      index + 1 == state.modal.responseData!.length
                                          ? SizedBox(height: 13.h)
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              );
            } else if (state is PackagesLoadingState) {
              return MyLoader();
            } else {
              return MyErrorWidget(onPressed: () {
                var cubit = PackagesCubit.get(context);
                cubit.getPackages();
              });
            }
          },
        ),
      ),
    );
  }
}
