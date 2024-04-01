import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salarynow/utils/keyboard_bottom_inset.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_box_continue_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/req_doc_widget/upload_document_widget.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import '../../utils/on_screen_loader.dart';
import '../../utils/snackbar.dart';
import '../../widgets/dialog_box_widget.dart';
import '../../widgets/text_widget.dart';
import '../cubit/file_picker_cubit/file_picker_cubit.dart';
import '../cubit/get_doc_cubit/get_document_cubit.dart';
import '../cubit/req_doc_cubit/req_document_cubit.dart';

class SalarySlipMonthScreen extends StatelessWidget {
  final Function? refreshSalary;
  final String title;

  SalarySlipMonthScreen({Key? key, this.title = "", this.refreshSalary}) : super(key: key);

  File? file;
  String? extension;
  String? base64String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 3),
      body: BlocListener<ReqDocumentCubit, ReqDocumentState>(
        listener: (context, state) {
          if (state is ReqDocumentLoading) {
            MyScreenLoader.onScreenLoader(context);
          }

          if (state is ReqDocumentLoaded) {
            Navigator.pop(context);
            var cubit = GetDocumentCubit.get(context);
            cubit.getDocument(doctype: 'salary_slip');
            refreshSalary!();
            Navigator.pop(context);

            MySnackBar.showSnackBar(context, state.modal.responseMsg ?? '');
          }
          if (state is ReqDocumentError) {
            Navigator.pop(context);
            MySnackBar.showSnackBar(context, state.error);
          }
        },
        child: Column(
          children: [
            Expanded(
                flex: 11,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoTitleWidget(
                          title: title.toString(),
                          subtitle: "${MyWrittenText.uploadSalarySlipMonthText} ${title.toString()}",
                        ),
                        BlocProvider(
                            create: (context) => FilePickerCubit(),
                            child: BlocConsumer<FilePickerCubit, FilePickerState>(listener: (context, state) {
                              if (state is FilePickerError) {
                                if (state.error == 'Storage Permission Denied') {
                                  MyDialogBox.openPermissionAppSetting(
                                      context: context,
                                      error: state.error,
                                      onPressed: () => openAppSettings().whenComplete(() => Navigator.pop(context)));
                                } else {
                                  Navigator.pop(context);
                                  MySnackBar.showSnackBar(context, state.error);
                                }
                              }
                            }, builder: (context, state) {
                              return BlocBuilder<FilePickerCubit, FilePickerState>(builder: (context, state) {
                                var cubit = FilePickerCubit.get(context);
                                if (state is FilePickerLoading) {
                                  return SizedBox(height: 400.h, child: const Center(child: MyLoader()));
                                }
                                if (state is FilePickerSuccess) {
                                  extension = state.extension;
                                  file = state.file;
                                  base64String = state.base64;
                                  return state.extension == 'pdf'
                                      ? SizedBox(
                                          height: 300.h,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const MyText(text: "PDF is selected"),
                                              SizedBox(height: 50.h),
                                              Container(
                                                height: 55.h,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  color: MyColor.highLightBlueColor,
                                                  border: Border.all(
                                                    color: MyColor.turcoiseColor,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    cubit.pickFile();
                                                  },
                                                  child: SizedBox(
                                                    width: double.maxFinite,
                                                    child: Center(
                                                      child: MyText(
                                                        text: 'Upload Your Document',
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : UploadDocumentWidget(
                                          image: state.base64,
                                          buttonTitle: 'Upload Your Document',
                                          secondButtonTitle: MyWrittenText.browseText,
                                          onTapFirstButton: () {
                                            cubit.pickFile();
                                          },
                                          title: '',
                                        );
                                } else {
                                  return UploadDocumentWidget(
                                    image: null,
                                    widget: Center(
                                      child: Image.asset(
                                        MyImages.docPlaceholder,
                                        width: 90.w,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    buttonTitle: MyWrittenText.browseText,
                                    secondButtonTitle: MyWrittenText.browseText,
                                    onTapFirstButton: () {
                                      cubit.pickFile(isPdf: false);
                                    },
                                    title: '',
                                  );
                                }
                              });
                            }))
                      ],
                    )))),
            if (MyKeyboardInset.hideWidgetByKeyboard(context))
              InfoBoxContinueWidget(
                onPressed: () {
                  if (file != null) {
                    context.read<ReqDocumentCubit>().postStatement(file: file!, month: title, type: 'salary_slip');
                  } else {
                    MySnackBar.showSnackBar(context, 'Select Your Document');
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
