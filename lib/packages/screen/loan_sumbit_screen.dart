import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salarynow/information/cubit/employment_cubit/loan_emp_cubit.dart';
import 'package:salarynow/packages/cubit/apply_loan_cubit/apply_loan_cubit.dart';
import 'package:salarynow/permission_handler/cubit/all_permission_cubit/permission_cubit.dart';
import 'package:salarynow/permission_handler/cubit/call_log_cubit/call_logs_cubit.dart';
import 'package:salarynow/permission_handler/cubit/location_cubit/location_tracker_cubit.dart';
import 'package:salarynow/permission_handler/cubit/sms_cubit/sms_cubit.dart';
import 'package:salarynow/routing/route_path.dart';
import 'package:salarynow/utils/keyboard_bottom_inset.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_textfield_widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import '../../information/screens/profession_screen/professional_info_screen.dart';
import '../../security/cubit/security_cubit.dart';
import '../../storage/local_storage.dart';
import '../../storage/local_user_modal.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import '../../utils/money_seperator.dart';
import '../../utils/on_screen_loader.dart';
import '../../utils/written_text.dart';
import '../../widgets/text_widget.dart';
import '../cubit/loan_slider_cubit/loan_slider_cubit.dart';
import '../cubit/slider_cubit.dart';
import '../network/modal/loan_calculator_modal.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class LoanSubmitScreen extends StatefulWidget {
  final String productId;
  final String maxAmount;
  final String value;
  final LoanCalculatorModal loanCalculatorModal;

  const LoanSubmitScreen(
      {Key? key,
      required this.productId,
      required this.maxAmount,
      required this.loanCalculatorModal,
      required this.value})
      : super(key: key);

  @override
  State<LoanSubmitScreen> createState() => _LoanSubmitScreenState();
}

class _LoanSubmitScreenState extends State<LoanSubmitScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController purposeLoanController = TextEditingController();

  double? _value;
  String? companyName;
  String? salary;

  double minAmount = 2000.0;

  static LoanCalculatorModal? loanCalculatorModal;

  var data = loanCalculatorModal?.responseData!;
  LocalUserModal? localUserModal = MyStorage.getUserData();

  bool debugFlag = false;

  @override
  void initState() {
    super.initState();
    var cubit = SecurityCubit.get(context);
    cubit.checkDebugging();
    WidgetsBinding.instance.addObserver(this);

    data = widget.loanCalculatorModal.responseData;
    _value = double.parse(widget.value);
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    purposeLoanController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        var cubit = SecurityCubit.get(context);
        cubit.checkDebugging();
        break;
      case AppLifecycleState.inactive:
        // SecurityCubit.get(context).close();
        break;
      case AppLifecycleState.paused:
        if (debugFlag == true) {
          Navigator.pop(context);
        }

        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const InfoCustomAppBar(navigatePopNumber: 2),
        body: GestureDetector(
          onTap: () => MyKeyboardInset.dismissKeyboard(context),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<SliderCubit, double>(
                            builder: (context, state) {
                              return MyText(
                                text:
                                    "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(roundOffValue(state.toString().split('.').first))}",
                                fontSize: 40.sp,
                              );
                            },
                          ),
                          BlocBuilder<LoanSliderCubit, LoanSliderState>(
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    MyDialogBox.loanAmountDialogBox(
                                        maxAmount: widget.maxAmount,
                                        context: context,
                                        onSelected: (data) {
                                          setState(() {
                                            _value = roundToNearest(double.parse(data), 500.0);
                                            var selectorCubit = LoanSliderCubit.get(context);
                                            selectorCubit.postLoanAmount(
                                                isLoanSubmitScreen: true,
                                                productId: widget.productId,
                                                loanAmount: _value.toString());
                                          });
                                          context.read<SliderCubit>().updateSliderValue(_value!);
                                        });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30.sp,
                                    color: MyColor.blackColor,
                                  ));
                            },
                          )
                        ],
                      ),
                      BlocListener<LoanSliderCubit, LoanSliderState>(
                        listener: (context, state) {
                          if (state is LoanSlider2Loading) {
                            MyScreenLoader.onScreenLoader(context);
                          }
                          if (state is LoanSlider2Error) {
                            MySnackBar.showSnackBar(context, state.error);
                            Navigator.pop(context);
                          }
                          if (state is LoanSliderLoaded) {
                            loanCalculatorModal = state.modal;
                            setState(() {
                              data = state.modal.responseData!;
                            });
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
                                  thumbShape: const SfThumbShape(),
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
                                      isLoanSubmitScreen: true,
                                      productId: widget.productId,
                                      loanAmount: roundOffValue(newValue.toString()),
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
                            offset: const Offset(0, 3),
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
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoTextFieldWidget(
                          title: MyWrittenText.purposeOfLoanText,
                          textEditingController: purposeLoanController,
                          hintText: MyWrittenText.purposeOfLoanText,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter purpose of loan';
                            } else if (value.startsWith("0")) {
                              return 'Please enter purpose of loan';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<LoanEmpCubit, LoanEmpState>(
                          builder: (context, state) {
                            if (state is LoanEmpLoaded) {
                              return SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyText(text: 'Company Name', fontSize: 18.sp),
                                            MyText(
                                                text: state.empDetailModal.responseData?.companyName ?? '',
                                                color: MyColor.subtitleTextColor),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfessionalInfoScreen(noHitProfileApi: true)));
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: MyColor.subtitleTextColor,
                                            ))
                                      ],
                                    ),
                                    MyText(text: 'Salary', fontSize: 18.sp),
                                    MyText(
                                      text:
                                          "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(state.empDetailModal.responseData?.salary ?? "")} per month",
                                      color: MyColor.subtitleTextColor,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
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
                                    color: MyColor.subtitleTextColor,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: MyText(
                                text: MyWrittenText.processingFee,
                                color: MyColor.subtitleTextColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
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
                                    color: MyColor.subtitleTextColor,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 12,
                              child: MyText(
                                text: MyWrittenText.gstCharge,
                                color: MyColor.subtitleTextColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  MultiBlocListener(
                    listeners: [
                      BlocListener<SecurityCubit, SecurityState>(listener: (context, state) {
                        if (state is SecurityDialogState) {
                          MyDialogBox().checkDebugging(
                            context: context,
                            debugging: state.isDebugging,
                            // realDevice: state.isRealDevice,
                          );
                          debugFlag = true;
                        }
                        if (state is SecurityNoDialogState) {
                          debugFlag = false;
                        }
                      }),
                      BlocListener<ApplyLoanCubit, ApplyLoanState>(
                        listener: (context, state) {
                          if (state is ApplyLoanLoaded) {
                            MyKeyboardInset.dismissKeyboard(context);
                            var dashBoardCubit = DashboardCubit.get(context);
                            dashBoardCubit.getDashBoardData();
                            Navigator.pop(context);
                            MyDialogBox.successfulLoanDialogBox(
                              amount:
                                  IndianMoneySeperator.formatAmount(roundOffValue(_value.toString().split('.').first)),
                              userName: localUserModal!.responseData!.name!,
                              context: context,
                            );
                          }
                          if (state is ApplyLoanError) {
                            Navigator.pop(context);
                            if (state.error.responseStatus == 0) {
                              MySnackBar.showSnackBar(context, state.error.responseMsg!);
                            } else {
                              Navigator.pushNamed(context, RoutePath.loanCriteria);
                            }
                          }
                          // if (state is ApplyLoanLoading) {
                          //   MyScreenLoader.onScreenLoader(context);
                          // }
                        },
                      ),
                      BlocListener<PermissionCubit, PermissionState>(
                        listener: (context, state) {
                          if (state is AllPermissionLoading) {
                            MyScreenLoader.onScreenLoader(context);
                          }
                          if (state is AllPermissionGranted) {
                            Navigator.pop(context);
                            if (_formKey.currentState!.validate()) {
                              MyDialogBox.alertCheckLoan(
                                  context: context,
                                  amount: IndianMoneySeperator.formatAmount(
                                      roundOffValue(_value.toString().split('.').first)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    MyScreenLoader.onScreenLoader(context);
                                    CallLogsCubit.get(context).fetchCallLogsAndPostToAPI();
                                  });
                            } else {
                              MySnackBar.showSnackBar(context, 'Fill Purpose of Loan Field');
                            }
                          }
                          if (state is AllPermissionDenied) {
                            Navigator.pop(context);
                            MyDialogBox.allPermissionDialogBox(
                              context: context,
                              onPressed: () {
                                openAppSettings().whenComplete(() => Navigator.pop(context));
                              },
                              camera: state.allowCameraPermission,
                              phone: state.allowPhonePermission,
                              // contact: state.allowContactPermission,
                              location: state.allowLocationPermission,
                              sms: state.allowSmsPermission,
                              // storage: state.allowStoragePermission
                            );
                          }
                        },
                      ),

                      /// Call Log Cubit
                      BlocListener<CallLogsCubit, CallLogsState>(listener: (context, state) {
                        if (state is CallLogLoaded) {
                          SmsCubit.get(context).fetchSmSAndPostToAPI();
                        }
                        if (state is CallLogError) {
                          Navigator.pop(context);
                          MySnackBar.showSnackBar(context, state.errorMessage);
                        }
                      }),

                      /// Sms Cubit
                      BlocListener<SmsCubit, SmsState>(listener: (context, state) {
                        if (state is SmsLoadedState) {
                          LocationTrackerCubit.get(context).postLocation(loanNumber: '');
                        }
                        if (state is SmsErrorState) {
                          Navigator.pop(context);
                          MySnackBar.showSnackBar(context, state.errorMessage);
                        }
                      }),

                      ///Location Cubit
                      BlocListener<LocationTrackerCubit, LocationTrackerState>(listener: (context, state) {
                        if (state is LocationTrackerLoaded) {
                          applyLoan();
                        }
                        if (state is LocationTrackerError) {
                          applyLoan();
                          // Navigator.pop(context);
                          // MySnackBar.showSnackBar(context, state.errorMessage);
                        }
                      }),
                    ],
                    child: MyButton(
                        text: MyWrittenText.applyLoanText,
                        onPressed: () {
                          var cubit = PermissionCubit.get(context);
                          cubit.reqAllPermission();
                        }),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                    : const SizedBox(),
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
        const Divider()
      ],
    );
  }

  void applyLoan() {
    var applyLoanCubit = ApplyLoanCubit.get(context);
    applyLoanCubit
        .postApplyLoan(
          loanAmount: roundOffValue(_value.toString().split('.').first),
          productId: widget.productId,
          totalPayAmount: data?.totalPayAmount.toString() ?? '',
          loanTenure: data?.loanTenure ?? '',
          loanPurpose: purposeLoanController.text.trim(),
          interestAmount: data?.interestAmt.toString() ?? '',
        )
        .whenComplete(() => Navigator.pop(context));
  }

  double roundToNearest(double value, double nearest) {
    return (value / nearest).roundToDouble() * nearest;
  }

  // int calculateDivisions(double min, double max, double divisions) {
  //   return ((max - min) / divisions).round();
  // }

  String roundOffValue(String myValue) {
    myValue = myValue.split('.').first;

    if (myValue.endsWith("99")) {
      myValue = (int.parse(myValue) + 1).toString();
    }
    return myValue;
  }
}
