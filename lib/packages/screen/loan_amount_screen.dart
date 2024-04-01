import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:salarynow/packages/cubit/loan_amount_cubit/loan_amount_cubit.dart';
import 'package:salarynow/packages/network/modal/loan_calculator_modal.dart';
import 'package:salarynow/packages/screen/check_ref_number.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/utils/images.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../utils/color.dart';
import '../../utils/money_seperator.dart';
import '../../widgets/information_widgets/info_appbar_widget.dart';
import '../cubit/loan_slider_cubit/loan_slider_cubit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../cubit/slider_cubit.dart';

class LoanAmountScreen extends StatefulWidget {
  final String productId;
  final String maxAmount;
  const LoanAmountScreen({Key? key, required this.productId, required this.maxAmount}) : super(key: key);

  @override
  State<LoanAmountScreen> createState() => _LoanAmountScreenState();
}

class _LoanAmountScreenState extends State<LoanAmountScreen> {
  double minAmount = 2000.0;
  double _value = 2000.0;

  @override
  void initState() {
    super.initState();

    context.read<SliderCubit>().updateSliderValue(2000);
    var loanCubit = LoanCalculatorCubit.get(context);
    loanCubit.postLoanAmount(loanAmount: minAmount.toString(), productId: widget.productId);
  }

  static LoanCalculatorModal? loanCalculatorModal;

  var data = loanCalculatorModal?.responseData!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: InfoCustomAppBar(navigatePopNumber: 1),
        body: BlocListener<LoanCalculatorCubit, LoanCalculatorState>(
          listener: (context, state) {
            if (state is LoanCalculatorLoaded) {
              loanCalculatorModal = state.modal;
              data = state.modal.responseData!;
            }
          },
          child: BlocBuilder<LoanCalculatorCubit, LoanCalculatorState>(
            builder: (context, state) {
              if (state is LoanCalculatorLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(
                            text: MyWrittenText.loanAmountText,
                            fontSize: 24.sp,
                          ),
                          SizedBox(height: 5.h),
                          BlocBuilder<SliderCubit, double>(
                            builder: (context, state) {
                              return MyText(
                                text:
                                    "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(roundOffValue(state.toString().split('.').first))}",
                                fontSize: 40.sp,
                              );
                            },
                          ),
                          BlocListener<LoanSliderCubit, LoanSliderState>(
                            listener: (context, state) {
                              if (state is LoanSliderLoading) {
                                MyScreenLoader.onScreenLoader(context);
                              }
                              if (state is LoanSliderError) {
                                Navigator.pop(context);
                              }
                              if (state is LoanSliderLoaded) {
                                loanCalculatorModal = state.modal;

                                setState(() {
                                  data = state.modal.responseData!;
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: BlocBuilder<SliderCubit, double>(
                              builder: (context, state) {
                                return SfSliderTheme(
                                  data: SfSliderThemeData(
                                    activeTrackHeight: 18.h,
                                    inactiveTrackHeight: 18.h,
                                    thumbRadius: 18.r,
                                  ),
                                  child: SfSlider(
                                      stepSize: 500,
                                      thumbShape: SfThumbShape(),
                                      thumbIcon: Image.asset(
                                        MyImages.coinImage,
                                      ),
                                      min: 2000,
                                      max: double.parse(widget.maxAmount),
                                      value: state,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                        context
                                            .read<SliderCubit>()
                                            .updateSliderValue(double.parse(roundOffValue(value.toString())));
                                      },
                                      onChangeEnd: (newValue) {
                                        var cubit = LoanSliderCubit.get(context);
                                        cubit.postLoanAmount(
                                          isLoanSubmitScreen: false,
                                          productId: widget.productId,
                                          loanAmount: newValue.toString(),
                                        );
                                      }),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1.5,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5.r),
                            color: MyColor.whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                              buildRowAndColumn(
                                showAstric: true,
                                title: MyWrittenText.totalApr,
                                subtitle: data!.totalAPR!,
                              ),
                              buildRowAndColumn(
                                title: MyWrittenText.totalInterestText,
                                subtitle:
                                    "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data!.interestAmt!.toString())}",
                              ),
                              buildRowAndColumn(
                                title: MyWrittenText.repaymentAmountText,
                                subtitle:
                                    "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data!.totalPayAmount!.toString())}",
                              ),
                              BlocBuilder<SliderCubit, double>(
                                builder: (context, state) {
                                  return buildRowAndColumn(
                                    title: MyWrittenText.loanAmountText,
                                    subtitle:
                                        "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(roundOffValue(state.toString().split('.').first))}",
                                  );
                                },
                              ),
                              buildRowAndColumn(
                                title: MyWrittenText.tenureText,
                                subtitle: "${data?.loanTenure!} Days",
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: "*",
                                          fontSize: 20.sp,
                                          color: MyColor.redColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: MyText(
                                      text: MyWrittenText.irrMethod,
                                      color: MyColor.subtitleTextColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1.5,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5.r),
                            color: MyColor.whiteColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 5.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.h),
                                            child: MyText(
                                              text: "S.No.",
                                              color: MyColor.turcoiseColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 5.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.h),
                                            child: MyText(
                                              text: MyWrittenText.interestText,
                                              color: MyColor.turcoiseColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 5.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.h),
                                            child: MyText(
                                              text: 'EMI Amount',
                                              color: MyColor.turcoiseColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: data?.emiData?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var emiData = data?.emiData;
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.h),
                                                child: MyText(
                                                  text: "${emiData![index].emiMonth!}",
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.h),
                                                child: MyText(
                                                  text:
                                                      "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(emiData[index].emiInterest!)}",
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.h),
                                                child: MyText(
                                                  text:
                                                      "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(emiData[index].monthlyEmiAmount!)}",
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      BlocBuilder<DashboardCubit, DashboardState>(
                        builder: (context, state) {
                          if (state is DashboardLoaded) {
                            var data = state.dashBoardModal.responseData!.loanDetails;
                            return switchCaseStatement(data!.loanstatus!) == true
                                ? BlocListener<ProfileCubit, ProfileState>(
                                    listener: (context, state) {
                                      if (state is ProfileLoading) {
                                        MyScreenLoader.onScreenLoader(context);
                                      }
                                      if (state is ProfileLoaded) {
                                        Navigator.pop(context);
                                        var data = state.profileModal.responseData;
                                        if (data!.selfi! == false &&
                                            data.personal! == false &&
                                            data.employeement == false &&
                                            data.residential == false &&
                                            data.bank == false) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => CheckRefNumber(
                                                        value: roundOffValue(_value.toString().split('.').first),
                                                        loanCalculatorModal: loanCalculatorModal!,
                                                        maxAmount: widget.maxAmount,
                                                        productId: widget.productId,
                                                      )));
                                        } else {
                                          MyDialogBox.checkDocDialogBox(context: context, onPressed: () {});
                                        }
                                      }
                                      if (state is ProfileError) {
                                        Navigator.pop(context);
                                        MySnackBar.showSnackBar(context, state.error);
                                      }
                                    },
                                    child: MyButton(
                                        text: MyWrittenText.proceedText,
                                        onPressed: () {
                                          var cubit = ProfileCubit.get(context);
                                          cubit.getProfile();
                                        }),
                                  )
                                : SizedBox();
                          }
                          return SizedBox();
                        },
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                );
              } else if (state is LoanCalculatorLoading) {
                return MyLoader();
              } else {
                return MyErrorWidget(
                  onPressed: () {
                    var loanCubit = LoanCalculatorCubit.get(context);
                    loanCubit.postLoanAmount(loanAmount: minAmount.toString(), productId: widget.productId);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  bool switchCaseStatement(String argument) {
    Map<String, bool> cases = {
      '': true,

      /// Pending
      '0': false,

      /// Approved
      '1': false,

      /// Disbursed
      '2': false,

      /// Close
      '3': true,

      /// Reject
      '4': false,

      /// Not Interested
      '5': true,
    };

    return cases[argument] ?? false;
  }

  Column buildRowAndColumn({required String title, required String subtitle, bool? showAstric}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                showAstric != null
                    ? MyText(
                        text: "*",
                        fontSize: 16.sp,
                        color: MyColor.redColor,
                      )
                    : SizedBox(),
                MyText(
                  text: title,
                  fontSize: 16.sp,
                ),
              ],
            ),
            MyText(
              text: subtitle,
              color: MyColor.turcoiseColor,
            )
          ],
        ),
        Divider()
      ],
    );
  }

  // int calculateDivisions(double min, double max, double divisions) {
  //   return ((max - min) / divisions).round();
  // }

  String roundOffValue(String myValue) {
    if (myValue.endsWith("99")) {
      myValue = (int.parse(myValue) + 1).toString();
    }
    return myValue;
  }
}
