import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salarynow/required_document/cubit/bank_statement_date/bank_statement_get_modal_cubit.dart';
import 'package:salarynow/required_document/cubit/get_doc_cubit/get_document_cubit.dart';
import 'package:salarynow/required_document/screens/bank_statement/bank_statement_web_view.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/images.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../utils/on_screen_loader.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/date_range_dialog_box.dart';
import '../../../widgets/dotted_border_widget.dart';
import '../../../widgets/loader.dart';
import '../../cubit/file_picker_cubit/file_picker_cubit.dart';
import '../../cubit/req_doc_cubit/req_document_cubit.dart';

class BankStatement extends StatefulWidget {
  final Function? refreshSalary;

  const BankStatement({Key? key, this.refreshSalary}) : super(key: key);

  @override
  State<BankStatement> createState() => _BankStatementState();
}

class _BankStatementState extends State<BankStatement> {
  File? file;
  String? extension;
  String? base64String;
  String? startDate;
  String? endDate;
  String? password;

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var cubit = GetDocumentCubit.get(context);
    cubit.getDocument(doctype: 'bank_statement');
    var bankDate = BankStatementGetCubit.get(context);
    bankDate.getDate();
    FilePickerCubit.get(context).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 2),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoTitleWidget(
                title: MyWrittenText.bankStatementText,
                subtitle: MyWrittenText.bankStateSubTitleText,
              ),
              SizedBox(height: 20.h),
              ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    size: 30.sp,
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: const MyText(
                    text: MyWrittenText.bankStateStepOneText,
                    fontWeight: FontWeight.w300,
                  )),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: 30.sp,
                ),
                title: const MyText(
                  text: MyWrittenText.bankStateStepTwoText,
                  fontWeight: FontWeight.w300,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              SizedBox(height: 20.h),
              BlocBuilder<BankStatementGetCubit, BankStatementGetState>(
                builder: (context, state) {
                  if (state is BankStatementGetLoaded) {
                    return Column(
                      children: [
                        state.bankStatementModal.data!.showmessage!.isNotEmpty
                            ? MyText(
                                textAlign: TextAlign.center,
                                color: MyColor.turcoiseColor,
                                text: state.bankStatementModal.data!.showmessage!.toString(),
                                fontWeight: FontWeight.w300,
                              )
                            : SizedBox(),
                        SizedBox(height: 20.h),
                        state.bankStatementModal.data!.uploadpdf == true
                            ? Column(
                                children: [
                                  BlocConsumer<FilePickerCubit, FilePickerState>(
                                    listener: (context, state) {
                                      if (state is FilePickerError) {
                                        if (state.error == 'Storage Permission Denied') {
                                          MyDialogBox.openPermissionAppSetting(
                                              context: context,
                                              error: state.error,
                                              onPressed: () =>
                                                  openAppSettings().whenComplete(() => Navigator.pop(context)));
                                        } else {
                                          MySnackBar.showSnackBar(context, state.error);
                                        }
                                      }
                                    },
                                    builder: (context, state) {
                                      return BlocBuilder<FilePickerCubit, FilePickerState>(
                                        builder: (context, state) {
                                          var cubit = FilePickerCubit.get(context);
                                          if (state is FilePickerLoading) {
                                            return const MyLoader();
                                          }
                                          if (state is FilePickerSuccess) {
                                            extension = state.extension;
                                            file = state.file;
                                            base64String = state.base64;
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: MyColor.turcoiseColor,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      MyText(
                                                        text: " Your E-Statement Details",
                                                        fontSize: 16.sp,
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      MyText(
                                                        text: "Selected File : ${state.file.path.split("/").last}",
                                                        fontSize: 16.sp,
                                                      ),
                                                      startDate != null
                                                          ? MyText(
                                                              text: "Start Date : $startDate",
                                                              fontSize: 16.sp,
                                                            )
                                                          : const SizedBox(),
                                                      endDate != null
                                                          ? MyText(
                                                              text: "End Date : $endDate",
                                                              fontSize: 16.sp,
                                                            )
                                                          : const SizedBox(),
                                                      password != null
                                                          ? MyText(
                                                              text: password!.isNotEmpty
                                                                  ? "Password : $password"
                                                                  : "Password : N/A",
                                                              fontSize: 16.sp,
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return DateRangeDialog(
                                                            startDate: (data) {
                                                              startDate = data;
                                                              setState(() {});
                                                            },
                                                            endDate: (data) {
                                                              endDate = data;
                                                              setState(() {});
                                                            },
                                                            password: (data) {
                                                              password = data;
                                                              setState(() {});
                                                            },
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 55.h,
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      color: MyColor.highLightBlueColor,
                                                      border: Border.all(
                                                        color: MyColor.turcoiseColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.calendar_month,
                                                                color: MyColor.greenColor,
                                                              ),
                                                              SizedBox(width: 10.w),
                                                              MyText(
                                                                text: "Select Date",
                                                                fontSize: 16.sp,
                                                              ),
                                                            ],
                                                          ),
                                                          const Icon(
                                                            Icons.edit,
                                                            color: MyColor.greenColor,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    cubit.pickFile(isPdf: true);
                                                  },
                                                  child: Container(
                                                    height: 55.h,
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      color: MyColor.highLightBlueColor,
                                                      border: Border.all(
                                                        color: MyColor.turcoiseColor,
                                                      ),
                                                    ),
                                                    child: SizedBox(
                                                      width: double.maxFinite,
                                                      child: Center(
                                                        child: MyText(
                                                          text: "Change the PDF",
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                BlocListener<ReqDocumentCubit, ReqDocumentState>(
                                                    listener: (context, state) {
                                                      if (state is ReqDocumentLoading) {
                                                        MyScreenLoader.onScreenLoader(context);
                                                      }
                                                      if (state is ReqDocumentLoaded) {
                                                        Navigator.pop(context);
                                                        var fileCubit = FilePickerCubit.get(context);
                                                        fileCubit.reset();
                                                        widget.refreshSalary!();
                                                        file = null;
                                                        startDate = null;
                                                        endDate = null;
                                                        password = null;
                                                        MySnackBar.showSnackBar(context, state.modal.responseMsg!);
                                                        var cubit = GetDocumentCubit.get(context);
                                                        cubit.getDocument(doctype: 'bank_statement');
                                                      }
                                                      if (state is ReqDocumentError) {
                                                        Navigator.pop(context);
                                                        MySnackBar.showSnackBar(context, state.error);
                                                      }
                                                    },
                                                    child: MyButton(
                                                      text: 'Upload',
                                                      onPressed: () {
                                                        if (file != null && startDate != null && endDate != null) {
                                                          context
                                                              .read<ReqDocumentCubit>()
                                                              .postStatement(
                                                                type: 'bank_statement',
                                                                file: file!,
                                                                startDate: startDate,
                                                                endDate: endDate,
                                                                password: password ?? "",
                                                              )
                                                              .whenComplete(() {});
                                                        } else {
                                                          MySnackBar.showSnackBar(
                                                              context,
                                                              file != null
                                                                  ? "Choose Your Start/End Date"
                                                                  : 'Pick a PDF');
                                                        }
                                                      },
                                                    ))
                                              ],
                                            );
                                          } else {
                                            return GestureDetector(
                                              onTap: () {
                                                cubit.pickFile(isPdf: true);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  // color: MyColor.highLightBlueColor,
                                                  border: Border.all(
                                                    color: MyColor.turcoiseColor,
                                                  ),
                                                ),
                                                width: double.maxFinite,
                                                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          MyImages.bankStatementImage,
                                                          width: 50.w,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                        SizedBox(width: 10.w),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            MyText(
                                                              text: 'Upload Your PDF',
                                                              fontSize: 20.sp,
                                                              // color: MyColor.titleTextColor,
                                                            ),
                                                            MyText(
                                                              text: MyWrittenText.addPdfStateText,
                                                              color: MyColor.subtitleTextColor,
                                                              fontWeight: FontWeight.w300,
                                                              fontSize: 14.sp,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: MyColor.turcoiseColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 25.h),
                                      child: const Align(alignment: Alignment.center, child: MyText(text: "OR"))),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const BankStatementWebView()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                          color: MyColor.turcoiseColor,
                                        ),
                                      ),
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                MyImages.netBanking,
                                                width: 50.w,
                                                fit: BoxFit.fitWidth,
                                              ),
                                              SizedBox(width: 10.w),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                    text: MyWrittenText.netBankingText,
                                                    fontSize: 20.sp,
                                                    // color: MyColor.titleTextColor,
                                                  ),
                                                  MyText(
                                                    text: MyWrittenText.addPdfStateText,
                                                    color: MyColor.subtitleTextColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 14.sp,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: MyColor.turcoiseColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: 25.h),
              BlocListener<GetDocumentCubit, GetDocumentState>(
                listener: (context, state) {
                  if (state is BankStatementLoaded) {
                    var bankDate = BankStatementGetCubit.get(context);
                    bankDate.getDate();
                  }
                },
                child: BlocBuilder<GetDocumentCubit, GetDocumentState>(
                  builder: (context, state) {
                    if (state is GetDocumentLoading) {
                      return const MyLoader();
                    } else if (state is BankStatementLoaded) {
                      var data = state.modal.data;
                      return state.modal.data!.isNotEmpty
                          ? Column(
                              children: [
                                MyText(text: "Your Uploaded PDF List", fontSize: 20.sp),
                                SizedBox(height: 10.h),
                                ListView.builder(
                                    itemCount: data?.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(vertical: 7.h),
                                        child: MyDottedBorder(
                                          widget: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.symmetric(vertical: 5.h),
                                                    width: 280.w,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(
                                                          text: data![index].bankStatementFile!,
                                                          maxLines: 3,
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        MyText(
                                                          text:
                                                              'From ${data[index].fromDate!} To ${data[index].toDate!}',
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w300,
                                                        ),
                                                      ],
                                                    )),
                                                CircleAvatar(
                                                  radius: 24.r,
                                                  backgroundColor: MyColor.greenColor,
                                                  child: CircleAvatar(
                                                    radius: 22.r,
                                                    backgroundColor: MyColor.whiteColor,
                                                    child: const Icon(
                                                      Icons.done,
                                                      color: MyColor.greenColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            )
                          : const SizedBox.shrink();
                    } else {
                      return MyErrorWidget(onPressed: () {
                        var cubit = GetDocumentCubit.get(context);
                        cubit.getDocument(doctype: 'bank_statement');
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
