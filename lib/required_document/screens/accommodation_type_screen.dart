import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salarynow/required_document/cubit/image_cubit.dart';
import 'package:salarynow/utils/keyboard_bottom_inset.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/validation.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_box_continue_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_textfield_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/onTap_textfield_icon_widget.dart';
import 'package:salarynow/widgets/radio_listile_widget.dart';
import 'package:salarynow/widgets/req_doc_widget/upload_document_widget.dart';
import '../../form_helper/network/modal/doc_accomodation_modal.dart';
import '../../storage/local_storage.dart';
import '../../utils/bottom_sheet.dart';
import '../../utils/snackbar.dart';
import '../cubit/req_doc_cubit/req_document_cubit.dart';

class AccommodationScreen extends StatefulWidget {
  final Function? refreshProfile;

  AccommodationScreen({Key? key, this.refreshProfile}) : super(key: key);

  @override
  State<AccommodationScreen> createState() => _AccommodationScreenState();
}

class _AccommodationScreenState extends State<AccommodationScreen> {
  String? firstImage;
  final TextEditingController documentController = TextEditingController();
  DocAccomodationModal? docAccomodationModal = MyStorage.getAccomadationData();

  int _selectedRadioButton = 1;
  String? documentType;
  String? docSelected;

  void _handleRadioButtonSelection(int value) {
    setState(() {
      _selectedRadioButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoCustomAppBar(navigatePopNumber: 2),
      body: BlocListener<ReqDocumentCubit, ReqDocumentState>(
        listener: (context, state) {
          if (state is ReqDocumentLoading) {
            MyScreenLoader.onScreenLoader(context);
          }
          if (state is ReqDocumentLoaded) {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.refreshProfile!();

            MySnackBar.showSnackBar(context, state.modal.responseMsg!);
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
                padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const InfoTitleWidget(
                        title: MyWrittenText.accommodationType,
                        subtitle: MyWrittenText.accommodationSubtitle,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: MyRadioListTile(
                            onTap: () {
                              _handleRadioButtonSelection(1);
                            },
                            groupValue: _selectedRadioButton,
                            value: 1,
                            onChanged: (value) {
                              _handleRadioButtonSelection(value!);
                            },
                            text: MyWrittenText.rentedText,
                          )),
                          Expanded(
                              child: MyRadioListTile(
                            onTap: () {
                              _handleRadioButtonSelection(0);
                            },
                            groupValue: _selectedRadioButton,
                            value: 0,
                            onChanged: (value) {
                              _handleRadioButtonSelection(value!);
                            },
                            text: MyWrittenText.ownText,
                          )),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      _selectedRadioButton == 0
                          ? SizedBox()
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (docAccomodationModal?.result != null) {
                                      MyBottomSheet.docTypeModalBottomSheet(
                                          fieldSelected: documentController.text.trim(),
                                          heading: 'Accommodation type',
                                          onSelectedID: (value) {
                                            documentType = value;

                                            if (docSelected != value) {
                                              firstImage = null;
                                              setState(() {});
                                            }
                                            docSelected = value;
                                          },
                                          onSelected: (value) {
                                            documentController.text = value;
                                          },
                                          context: context,
                                          list: docAccomodationModal!.result!);
                                    } else {
                                      MySnackBar.showSnackBar(context, "Some Error with Document Field");
                                    }
                                  },
                                  child: InfoTextFieldWidget(
                                    enabled: false,
                                    title: MyWrittenText.selectDocText,
                                    textEditingController: documentController,
                                    hintText: MyWrittenText.enterDocText,
                                    suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                docSelected != null
                                    ? UploadDocumentWidget(
                                        image: firstImage,
                                        twoButton: true,
                                        onTapSecondButton: () {
                                          pickImage('first', ImageSource.gallery);
                                        },
                                        buttonTitle: MyWrittenText.cameraText,
                                        secondButtonTitle: MyWrittenText.browseText,
                                        onTapFirstButton: () {
                                          pickImage('first', ImageSource.camera);

                                          // cubit.pickImage('first', ImageSource.camera);
                                        },
                                        title: MyWrittenText.uploadAgreeText,
                                      )
                                    : SizedBox()
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
            if (MyKeyboardInset.hideWidgetByKeyboard(context))
              InfoBoxContinueWidget(
                onPressed: () {
                  String doc = documentController.text.trim();
                  if (_selectedRadioButton == 1) {
                    if (doc.isNotEmpty && firstImage != null) {
                      context.read<ReqDocumentCubit>().postDocument(
                            file1: firstImage!,
                            file2: 'None',
                            type: 'rent_agreement_file',
                            docType: documentType!,
                            resiStatus: 'Rented',
                          );
                    } else {
                      if (firstImage == null) {
                        MySnackBar.showSnackBar(context, 'Select an Image');
                      } else if (doc.isEmpty) {
                        MySnackBar.showSnackBar(context, 'Select a Document Field');
                      } else {
                        MySnackBar.showSnackBar(context, 'Fill the details');
                      }
                    }
                  } else {
                    context.read<ReqDocumentCubit>().postDocument(
                        file1: "", file2: '', type: 'rent_agreement_file', docType: '', resiStatus: 'Own');
                  }
                },
              )
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(String key, ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      final croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        final imageBytes = await croppedFile.readAsBytes();
        final base64Image = base64Encode(imageBytes);

        firstImage = base64Image;

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
}
