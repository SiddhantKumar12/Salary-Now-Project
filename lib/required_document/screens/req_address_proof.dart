import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salarynow/form_helper/network/modal/doc_address_type.dart';
import 'package:salarynow/required_document/cubit/image_cubit.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import '../../storage/local_storage.dart';
import '../../utils/bottom_sheet.dart';
import '../../utils/keyboard_bottom_inset.dart';
import '../../utils/on_screen_loader.dart';
import '../../utils/snackbar.dart';
import '../../widgets/information_widgets/info_box_continue_widget.dart';
import '../../widgets/information_widgets/info_textfield_widget.dart';
import '../../widgets/information_widgets/info_title_widget.dart';
import '../../widgets/onTap_textfield_icon_widget.dart';
import '../../widgets/req_doc_widget/upload_document_widget.dart';
import '../cubit/req_doc_cubit/req_document_cubit.dart';

class ReqAddProofScreen extends StatefulWidget {
  final Function? refreshProfile;

  const ReqAddProofScreen({Key? key, this.refreshProfile}) : super(key: key);

  @override
  State<ReqAddProofScreen> createState() => _ReqAddProofScreenState();
}

class _ReqAddProofScreenState extends State<ReqAddProofScreen> {
  final TextEditingController addressProofController = TextEditingController();

  DocAddressTypeModal? docAddressTypeModal = MyStorage.getAddressData();
  String? firstImage;
  String? secondImage;
  String? documentType;
  String? docSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const InfoCustomAppBar(navigatePopNumber: 2),
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
                          title: MyWrittenText.addressProofTitleText,
                          subtitle: MyWrittenText.addressProofSubtitleText,
                          height: 100.h,
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            if (docAddressTypeModal?.result != null) {
                              MyBottomSheet.docTypeModalBottomSheet(
                                  fieldSelected: addressProofController.text.trim(),
                                  onSelectedID: (value) {
                                    documentType = value;
                                    if (docSelected != value) {
                                      firstImage = null;
                                      secondImage = null;
                                    }
                                    docSelected = value;

                                    setState(() {});
                                  },
                                  heading: 'Address Proof',
                                  onSelected: (value) {
                                    addressProofController.text = value;
                                  },
                                  context: context,
                                  list: docAddressTypeModal!.result!);
                            } else {
                              MySnackBar.showSnackBar(context, "Some Error with Doc Address Field");
                            }
                          },
                          child: InfoTextFieldWidget(
                            enabled: false,
                            title: MyWrittenText.addressProofNumberText,
                            textEditingController: addressProofController,
                            hintText: MyWrittenText.enterAddressProofNumberText,
                            textInputType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            suffixIcon: OnTapTextFieldSuffixIconWidget(
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        documentType != null
                            ? twoImageShow(documentType ?? "1")
                                ? Column(
                                    children: [
                                      UploadDocumentWidget(
                                        image: firstImage,
                                        title: MyWrittenText.uploadFrontSideText,
                                        buttonTitle: MyWrittenText.cameraText,
                                        onTapFirstButton: () {
                                          pickImage('first', ImageSource.camera);
                                        },
                                      ),
                                      SizedBox(height: 15.h),
                                      UploadDocumentWidget(
                                        image: secondImage,
                                        title: MyWrittenText.uploadBackSideText,
                                        buttonTitle: MyWrittenText.cameraText,
                                        onTapFirstButton: () {
                                          pickImage('second', ImageSource.camera);
                                        },
                                      ),
                                    ],
                                  )
                                : UploadDocumentWidget(
                                    image: firstImage,
                                    title: MyWrittenText.uploadPhotoText,
                                    buttonTitle: MyWrittenText.cameraText,
                                    onTapFirstButton: () {
                                      pickImage('first', ImageSource.camera);
                                      // cubit.pickImage('first', ImageSource.camera);
                                    },
                                  )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              BlocListener<ReqDocumentCubit, ReqDocumentState>(
                listener: (context, state) {
                  if (state is ReqDocumentLoading) {
                    MyScreenLoader.onScreenLoader(context);
                  }
                  if (state is ReqDocumentLoaded) {
                    Navigator.pop(context);
                    widget.refreshProfile!();
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.modal.responseMsg!);
                  }

                  if (state is ReqDocumentError) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.error);
                  }
                },
                child: InfoBoxContinueWidget(onPressed: () {
                  String doc = addressProofController.text.trim();

                  if (doc.isEmpty) {
                    MySnackBar.showSnackBar(context, 'Select a Document Field');
                  } else {
                    /// Two Image Upload
                    if (twoImageShow(documentType!)) {
                      if (firstImage != null && secondImage != null) {
                        context.read<ReqDocumentCubit>().postDocument(
                              file1: firstImage!,
                              file2: secondImage!,
                              type: 'address_proof',
                              docType: documentType!,
                            );
                      } else {
                        MySnackBar.showSnackBar(context, 'Select an Image');
                      }
                    } else {
                      /// One Image upload
                      if (firstImage != null) {
                        context.read<ReqDocumentCubit>().postDocument(
                              file1: firstImage!,
                              file2: '',
                              type: 'address_proof',
                              docType: documentType!,
                            );
                      } else {
                        MySnackBar.showSnackBar(context, 'Select an Image');
                      }
                    }
                  }
                }),
              )
            ],
          ),
        ));
  }

  Future<void> pickImage(String key, ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      final croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        final imageBytes = await croppedFile.readAsBytes();
        final base64Image = base64Encode(imageBytes);
        if (key == 'first') {
          firstImage = base64Image;
        } else {
          secondImage = base64Image;
        }
        setState(() {});
      }
    }
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    final cropper = ImageCropper();
    final croppedFile = await cropper.cropImage(compressQuality: 50, sourcePath: imageFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ]);
    return croppedFile;
  }

  bool twoImageShow(String documentType) {
    if (documentType == "5" || documentType == "6" || documentType == "18") {
      return true;
    } else {
      return false;
    }
  }
}
