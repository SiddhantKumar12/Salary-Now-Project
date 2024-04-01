import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/repayment/cuibt/ledger_cubit/ledger_cubit.dart';
import 'package:salarynow/repayment/cuibt/repayment/repayment_cubit.dart';
import 'package:salarynow/repayment/screen/previous_loan/previous_loan.dart';
import 'package:salarynow/repayment/screen/repayment_schedule.dart';
import 'package:salarynow/repayment/screen/repayment_web_view.dart';
import 'package:salarynow/utils/money_seperator.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/dashboard_widget/dashboard_list_tile.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/divider_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../storage/local_storage.dart';
import '../../widgets/empty_container.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class RepaymentScreen extends StatefulWidget {
  const RepaymentScreen({Key? key}) : super(key: key);

  @override
  State<RepaymentScreen> createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends State<RepaymentScreen> {
  double? _progress;

  @override
  void initState() {
    super.initState();
    RepaymentCubit.get(context).getRepayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(leading: true, popScreen: false, title: MyWrittenText.repaymentText),
      body: BlocListener<RepaymentCubit, RepaymentState>(
        listener: (context, state) {
          if (state is RepaymentErrorState) {
            if (state.error == MyWrittenText.unauthorizedAccess) {
              MyStorage.cleanAllLocalStorage();
              FlutterExitApp.exitApp();
            }
          }
        },
        child: BlocBuilder<RepaymentCubit, RepaymentState>(
          builder: (context, state) {
            if (state is RepaymentLoadedState) {
              var data = state.loanChargesModal.responseData;
              return data!.paymentStatus == 0
                  ? RefreshIndicator(
                      onRefresh: () {
                        var cubit = RepaymentCubit.get(context);
                        return cubit.getRepayment();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 200.h),
                        child: ListView(
                          children: [
                            const EmptyContainer(text: 'You have No Active Loans'),
                            SizedBox(height: 30.h),
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
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        var cubit = RepaymentCubit.get(context);
                        return cubit.getRepayment();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                MyText(
                                  text: data.loanStatus == '1'
                                      ? 'NA'
                                      : "₹ ${IndianMoneySeperator.formatAmount(data.data?.totalAmountWithPenalty ?? '')}",
                                  fontSize: 40.sp,
                                ),
                                const MyText(
                                  text: "Total Outstanding Amount",
                                  color: MyColor.subtitleTextColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.h),
                              color: MyColor.whiteColor,
                              child: Column(
                                children: [
                                  DashBoardListTileTwo(
                                    title: MyWrittenText.applicationNumberText,
                                    trailingTitle: data.data?.loanId!,
                                  ),
                                  DashBoardListTileTwo(
                                    title: MyWrittenText.approvedLoanText,
                                    trailingTitle:
                                        "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data.data?.approvedAmt ?? '')}",
                                  ),
                                  const MyDivider(),
                                  DashBoardListTileTwo(
                                    title: MyWrittenText.totalPayAmountText,
                                    trailingTitle:
                                        "${MyWrittenText.rupeeSymbol} ${IndianMoneySeperator.formatAmount(data.data?.totalPayAmount.toString() ?? "")}",
                                  ),
                                  DashBoardListTileTwo(
                                    title: MyWrittenText.tenureText,
                                    trailingTitle: "${data.data?.approvedTeneur ?? ''} Days",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.h),
                              color: MyColor.whiteColor,
                              child: Column(
                                children: [
                                  DashBoardListTileTwo(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RepaymentScheduleScreen(
                                                  loanChargesModal: state.loanChargesModal,
                                                ))),
                                    title: MyWrittenText.repaymentScheduleText,
                                    trailingWidget: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: MyColor.subtitleTextColor,
                                    ),
                                  ),
                                  const MyDivider(),
                                  DashBoardListTileTwo(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const PreviousLoanScreen())),
                                    title: MyWrittenText.previousLoan,
                                    trailingWidget: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: MyColor.subtitleTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            showMessage(data.data!.status!)
                                ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: MyText(
                                      text: data.data!.msg!,
                                      textAlign: TextAlign.center,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(height: 30.h),
                            data.paybtn == true
                                ? Column(
                                    children: [
                                      MyButton(
                                          text: MyWrittenText.repaymentText,
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => const RepaymentWebView()));
                                          }),
                                      SizedBox(height: 10.h),
                                    ],
                                  )
                                : const SizedBox(),
                            BlocProvider(
                              create: (context) => LedgerCubit(),
                              child: BlocConsumer<LedgerCubit, LedgerState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is LedgerLoaded) {
                                    return state.ledgerModal.responseData!.misStatus == true
                                        ? Column(
                                            children: [
                                              _progress != null
                                                  ? const CircularProgressIndicator()
                                                  : MyButton(
                                                      text: state.ledgerModal.responseData!.misButton!,
                                                      onPressed: () {
                                                        FileDownloader.downloadFile(
                                                            url: state.ledgerModal.responseData!.url!,
                                                            onDownloadError: (value) {
                                                              MySnackBar.showSnackBar(context, 'DownLoad InComplete');
                                                              setState(() {
                                                                _progress = null;
                                                              });
                                                            },
                                                            onProgress: (name, progress) {
                                                              setState(() {
                                                                _progress = progress;
                                                              });
                                                            },
                                                            onDownloadCompleted: (value) {
                                                              MySnackBar.showSnackBar(context, 'DownLoad Complete');
                                                              setState(() {
                                                                _progress = null;
                                                              });
                                                            });
                                                      }),
                                            ],
                                          )
                                        : const SizedBox();
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15.h)
                          ],
                        ),
                      ),
                    );
            } else if (state is RepaymentLoadingState) {
              return const MyLoader();
            } else if (state is RepaymentErrorState) {
              return state.error.toString() == 'Product Not Found Please Apply Loan first.'
                  ? RefreshIndicator(
                      onRefresh: () {
                        var cubit = RepaymentCubit.get(context);
                        return cubit.getRepayment();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 200.h),
                        child: ListView(
                          children: [
                            const EmptyContainer(text: 'You have No Active Loans'),
                            SizedBox(height: 30.h),
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
                    )
                  : MyErrorWidget(
                      onPressed: () {
                        var cubit = RepaymentCubit.get(context);
                        cubit.getRepayment();
                      },
                    );
            } else {
              return MyErrorWidget(
                onPressed: () {
                  var cubit = RepaymentCubit.get(context);
                  cubit.getRepayment();
                },
              );
            }
          },
        ),
      ),
    );
  }

  bool showMessage(String status) {
    bool msgShow = false;

    if (status == '2') {
      msgShow = true;
    } else if (status == '7') {
      msgShow = true;
    } else {
      msgShow = false;
    }

    return msgShow; // Output: true
  }
}
