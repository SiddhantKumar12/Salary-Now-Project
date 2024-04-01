import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import '../../../routing/route_path.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/banking_cubit/banking_detail_cubit.dart';
import 'info_detail_widget.dart';

class BankingViewScreen extends StatefulWidget {
  const BankingViewScreen({Key? key}) : super(key: key);

  @override
  State<BankingViewScreen> createState() => _BankingViewScreenState();
}

class _BankingViewScreenState extends State<BankingViewScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    isLoading = true;

    var cubit = BankingDetailCubit.get(context);
    cubit.getBankDetails();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const InfoCustomAppBar(),
      body: isLoading
          ? const MyLoader()
          : BlocConsumer<BankingDetailCubit, BankingDetailState>(
              listener: (context, state) {
                if (state is BankingDetailError) {
                  MySnackBar.showSnackBar(context, state.error.toString());
                }
              },
              builder: (context, state) {
                if (state is BankingDetailLoaded) {
                  var data = state.bankingDetailsModal.responseData;

                  return SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                          child: const InfoTitleWidget(
                            title: MyWrittenText.bankingInfoText,
                            subtitle: 'Please find the following Banking details of yours',
                          ),
                        ),
                        SizedBox(height: 15.h),
                        InfoDetailWidget(
                          title: MyWrittenText.bankNameText,
                          subtitle: data!.bankName!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.iFSCText,
                          subtitle: data.ifsc!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.branchAddressText,
                          subtitle: data.branchName!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.accNumberText,
                          subtitle: data.accountNo!,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(
                            children: [
                              ListTile(
                                  leading: Icon(
                                    Icons.info_outline,
                                    size: 35.sp,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  title: const MyText(
                                    text: MyWrittenText.bankStateStepOneText,
                                    fontWeight: FontWeight.w300,
                                  )),
                              ListTile(
                                leading: Icon(
                                  Icons.info_outline,
                                  size: 35.sp,
                                ),
                                title: const MyText(
                                  text: MyWrittenText.bankStateStepTwoText,
                                  fontWeight: FontWeight.w300,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              SizedBox(height: 20.h),
                              MyButton(
                                text: 'Upload Bank Statement',
                                onPressed: () {
                                  var profileCubit = ProfileCubit.get(context);
                                  Navigator.pushNamed(context, RoutePath.bankStatementScreen, arguments: () {
                                    profileCubit.getProfile();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is BankingDetailLoading) {
                  return const MyLoader();
                } else {
                  return MyErrorWidget(
                    onPressed: () {
                      var cubit = BankingDetailCubit.get(context);
                      cubit.getBankDetails();
                    },
                  );
                }
              },
            ),
    );
  }
}
