import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:salarynow/dashboard/cubit/sanction_cubit/get_sanction_cubit.dart';
import 'package:salarynow/dashboard/screen/agreement_letter/agreement_letter_web_view.dart';
import 'package:salarynow/dashboard/screen/not_interested_screen/not_interested_screen.dart';
import 'package:salarynow/repayment/cuibt/repayment/repayment_cubit.dart';
import 'package:salarynow/service_helper/api/api_strings.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../service_helper/web_view_contoller.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../../utils/color.dart';
import '../../../widgets/text_widget.dart';
import '../../network/modal/dashboard_modal.dart';

class SanctionLetterWebView extends StatefulWidget {
  final DashBoardModal dashBoardModal;

  const SanctionLetterWebView({super.key, required this.dashBoardModal});

  @override
  State<SanctionLetterWebView> createState() => _SanctionLetterWebViewState();
}

class _SanctionLetterWebViewState extends State<SanctionLetterWebView> {
  bool isLoading = true;
  late final WebViewController controller;
  LocalUserModal? localUserModal = MyStorage.getUserData();

  String sanctionUrl = '';

  bool isAgreeSanction = false;

  @override
  void initState() {
    super.initState();
    sanctionUrl =
        "${ApiStrings.baseUrl}${ApiStrings.loanSanction}${localUserModal!.responseData!.userId}/${widget.dashBoardModal.responseData!.loanDetails!.applyLoanDataId}";
    controller = WebViewHelper.getWebView(
        url: sanctionUrl,
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: 'Loan Sanction Letter'),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: WebViewWidget(
                      controller: controller,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: MyColor.containerBGColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                                  ),
                                  child: SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: Checkbox(
                                        value: isAgreeSanction,
                                        onChanged: (value) {
                                          setState(() {
                                            isAgreeSanction = value!;
                                          });
                                        },
                                      )),
                                ),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    if (isAgreeSanction) {
                                      isAgreeSanction = false;
                                    } else {
                                      isAgreeSanction = true;
                                    }
                                    setState(() {});
                                  },
                                  child: MyText(
                                      text: MyWrittenText.acceptSanctionLetter,
                                      color: MyColor.blackColor,
                                      fontSize: 15.sp),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocListener<SanctionCubit, SanctionState>(
                                  listener: (context, state) {
                                    if (state is SanctionLoaded) {
                                      Navigator.pop(context);
                                      var dashboardCubit = DashboardCubit.get(context);
                                      dashboardCubit.getDashBoardData();
                                      var repaymentCubit = RepaymentCubit.get(context);
                                      repaymentCubit.getRepayment();

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AgreementLetterWebView(dashBoardModal: widget.dashBoardModal),
                                          ));
                                    }
                                    if (state is SanctionLoading) {
                                      MyScreenLoader.onScreenLoader(context);
                                    }
                                    if (state is SanctionError) {
                                      Navigator.pop(context);
                                      MySnackBar.showSnackBar(context, state.error);
                                    }
                                  },
                                  child: MyButton(
                                    text: MyWrittenText.iAgreeText,
                                    onPressed: () {
                                      if (isAgreeSanction) {
                                        var sanctionCubit = SanctionCubit.get(context);
                                        sanctionCubit.postSanctionPdf(
                                            widget.dashBoardModal.responseData!.loanDetails!.applicationNo!);
                                      } else {
                                        MySnackBar.showSnackBar(context, 'Please accept the Terms and Conditions');
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: MyButton(
                                  text: MyWrittenText.notInterested,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NotInterestedScreen(
                                                dashBoardModal: widget.dashBoardModal,
                                              )),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          if (isLoading)
            const Center(
              child: MyLoader(),
            ),
        ],
      ),
    );
  }
}
