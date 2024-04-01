import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import '../../utils/keyboard_bottom_inset.dart';
import '../../utils/on_screen_loader.dart';
import '../../utils/snackbar.dart';
import '../../widgets/information_widgets/info_box_continue_widget.dart';
import '../../widgets/information_widgets/info_title_widget.dart';
import '../../widgets/req_doc_widget/upload_document_widget.dart';
import '../cubit/image_cubit.dart';
import '../cubit/req_doc_cubit/req_document_cubit.dart';

class ReqPanCardScreen extends StatelessWidget {
  final Function? refreshProfile;

  ReqPanCardScreen({Key? key, this.refreshProfile}) : super(key: key);

  String? firstImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 2),
      body: BlocListener<ReqDocumentCubit, ReqDocumentState>(
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
            MySnackBar.showSnackBar(context, state.error.toString());
          }
        },
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
                        title: MyWrittenText.panCardTitleText,
                        subtitle: MyWrittenText.panCardSubtitleText,
                        height: 100.h,
                      ),
                      SizedBox(height: 20.h),
                      BlocProvider(
                        create: (context) => ImagePickerCubit(),
                        child: BlocBuilder<ImagePickerCubit, Map<String, String>>(
                          builder: (context, state) {
                            firstImage = state['first'];
                            return UploadDocumentWidget(
                              image: firstImage,
                              title: MyWrittenText.uploadPhotoText,
                              buttonTitle: MyWrittenText.cameraText,
                              onTapFirstButton: () {
                                var cubit = ImagePickerCubit.get(context);
                                cubit.pickImage('first', ImageSource.camera);
                              },
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
              InfoBoxContinueWidget(onPressed: () {
                if (firstImage != null) {
                  var cubit = ReqDocumentCubit.get(context);
                  cubit.postDocument(file1: firstImage!, file2: "", type: 'pan_card');
                } else {
                  MySnackBar.showSnackBar(context, 'Pick An Image');
                }
              })
          ],
        ),
      ),
    );
  }
}
