import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salarynow/required_document/cubit/req_doc_cubit/req_document_cubit.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import '../../utils/keyboard_bottom_inset.dart';
import '../../utils/on_screen_loader.dart';
import '../../widgets/information_widgets/info_box_continue_widget.dart';
import '../../widgets/information_widgets/info_title_widget.dart';
import '../../widgets/req_doc_widget/upload_document_widget.dart';
import '../cubit/image_cubit.dart';

class ReqAadhaarCardScreen extends StatelessWidget {
  final Function? refreshProfile;

  ReqAadhaarCardScreen({Key? key, this.refreshProfile}) : super(key: key);

  final TextEditingController aadhaarCardController = TextEditingController();

  String? firstImage;
  String? secondImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 1),
      body: GestureDetector(
        onTap: () => MyKeyboardInset.dismissKeyboard(context),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoTitleWidget(
                        title: MyWrittenText.aadhaarCardTitleText,
                        subtitle: MyWrittenText.aadhaarCardSubtitleText,
                        height: 100.h,
                      ),
                      SizedBox(height: 20.h),
                      BlocProvider(
                        create: (context) => ImagePickerCubit(),
                        child: BlocBuilder<ImagePickerCubit, Map<String, String>>(
                          builder: (context, state) {
                            var cubit = ImagePickerCubit.get(context);

                            firstImage = state['first'];
                            secondImage = state['second'];
                            return Column(
                              children: [
                                UploadDocumentWidget(
                                  image: firstImage,
                                  title: MyWrittenText.uploadFrontSideText,
                                  buttonTitle: MyWrittenText.cameraText,
                                  onTapFirstButton: () {
                                    cubit.pickImage('first', ImageSource.camera);
                                  },
                                ),
                                SizedBox(height: 20.h),
                                UploadDocumentWidget(
                                  image: secondImage,
                                  title: MyWrittenText.uploadBackSideText,
                                  buttonTitle: MyWrittenText.cameraText,
                                  onTapFirstButton: () {
                                    cubit.pickImage('second', ImageSource.camera);
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (MyKeyboardInset.hideWidgetByKeyboard(context))
              BlocListener<ReqDocumentCubit, ReqDocumentState>(
                listener: (context, state) {
                  if (state is ReqDocumentLoading) {
                    MyScreenLoader.onScreenLoader(context);
                  }
                  if (state is ReqDocumentLoaded) {
                    Navigator.pop(context);
                    refreshProfile!();
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.modal.responseMsg!);
                  }
                  if (state is ReqDocumentError) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.error);
                  }
                },
                child: InfoBoxContinueWidget(
                  onPressed: () {
                    if (firstImage != null && secondImage != null) {
                      var cubit = ReqDocumentCubit.get(context);
                      cubit.postDocument(file1: firstImage!, file2: secondImage!, type: 'id_proof_file');
                    } else {
                      MySnackBar.showSnackBar(context, 'Pick both Image');
                    }
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
