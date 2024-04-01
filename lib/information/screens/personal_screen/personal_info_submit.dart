import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:salarynow/dashboard/cubit/get_selfie_cubit/get_selfie_cubit.dart';
import '../../../form_helper/network/modal/user_common_modal.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../required_document/cubit/get_doc_cubit/get_document_cubit.dart';
import '../../../required_document/screens/selfie_screen.dart';
import '../../../storage/local_storage.dart';
import '../../../utils/bottom_sheet.dart';
import '../../../utils/color.dart';
import '../../../utils/keyboard_bottom_inset.dart';
import '../../../utils/on_screen_loader.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/validation.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/information_widgets/info_box_continue_widget.dart';
import '../../../widgets/information_widgets/info_textfield_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/onTap_textfield_icon_widget.dart';
import '../../../widgets/profile_avatar.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/update_info_cubit/update_info_cubit.dart';

class PersonalInfoSubmit extends StatefulWidget {
  final bool relationStatus;
  final TextEditingController panCardController;
  final TextEditingController fullNameController;
  final TextEditingController genderController;
  final TextEditingController maritalStatusController;
  final TextEditingController fatherNameController;
  final TextEditingController alternateNoController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController empRelationShip1Controller;
  final TextEditingController relationName1Controller;
  final TextEditingController relationMobile1Controller;
  final TextEditingController empRelationship2Controller;
  final TextEditingController relationName2Controller;
  final TextEditingController relationMobile2Controller;
  const PersonalInfoSubmit({
    Key? key,
    required this.panCardController,
    required this.fullNameController,
    required this.genderController,
    required this.maritalStatusController,
    required this.fatherNameController,
    required this.alternateNoController,
    required this.emailController,
    required this.dobController,
    required this.empRelationShip1Controller,
    required this.relationName1Controller,
    required this.relationMobile1Controller,
    required this.empRelationship2Controller,
    required this.relationName2Controller,
    required this.relationMobile2Controller,
    required this.relationStatus,
  }) : super(key: key);

  @override
  State<PersonalInfoSubmit> createState() => _PersonalInfoSubmitState();
}

class _PersonalInfoSubmitState extends State<PersonalInfoSubmit> {
  final _formKey = GlobalKey<FormState>();
  UserCommonModal? userCommonModal = MyStorage.getUserCommonData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyKeyboardInset.dismissKeyboard(context),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InfoTitleWidget(
                          title: MyWrittenText.personalInfoText,
                          subtitle: MyWrittenText.pleaseSubtitleText,
                        ),
                        SizedBox(height: 50.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BlocBuilder<GetSelfieCubit, GetSelfieState>(
                                builder: (context, state) {
                                  if (state is GetSelfieLoaded) {
                                    return state.modal.data!.front!.isEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => const SelfieScreen()));
                                            },
                                            child: Column(
                                              children: [
                                                const MyProfileAvatar(),
                                                SizedBox(height: 10.h),
                                                const MyText(text: "Upload Selfie"),
                                              ],
                                            ),
                                          )
                                        : MyProfileAvatar(imageUrl: state.modal.data?.front);
                                  }
                                  if (state is GetDocumentLoading) {
                                    return CircleAvatar(
                                        radius: 50.r, backgroundColor: MyColor.turcoiseColor, child: const MyLoader());
                                  }
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                          fillColor: MyColor.textFieldFillColor,
                          enabled: false,
                          title: MyWrittenText.panCardNoText,
                          textEditingController: widget.panCardController,
                          hintText: MyWrittenText.enterPanCardNumberText,
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                          enabled: false,
                          fillColor: MyColor.textFieldFillColor,
                          title: MyWrittenText.fullNameText,
                          textEditingController: widget.fullNameController,
                          hintText: MyWrittenText.enterFullNameText,
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                          title: MyWrittenText.fatherName,
                          textEditingController: widget.fatherNameController,
                          hintText: MyWrittenText.enterFatherNameText,
                          textInputType: TextInputType.name,
                          validator: (value) => InputValidation.validateName(widget.fatherNameController.text.trim()),
                        ),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          title: MyWrittenText.alternateNoText,
                          textEditingController: widget.alternateNoController,
                          hintText: MyWrittenText.enterAltNoText,
                          textInputType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) =>
                              InputValidation.validateNumber(widget.alternateNoController.text.trim()),
                        ),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                          enabled: false,
                          fillColor: MyColor.textFieldFillColor,
                          title: MyWrittenText.emailIDText,
                          textEditingController: widget.emailController,
                          hintText: MyWrittenText.enterEmailIdText,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                          enabled: false,
                          fillColor: MyColor.textFieldFillColor,
                          title: MyWrittenText.dOBText,
                          textEditingController: widget.dobController,
                          hintText: MyWrittenText.enterDOBText,
                        ),
                        SizedBox(height: 15.h),
                        GestureDetector(
                          onTap: () {
                            if (userCommonModal?.responseData?.gender! != null) {
                              MyBottomSheet.commonUserModalBottomSheet(
                                  fieldSelected: widget.genderController.text.trim(),
                                  heading: 'Gender',
                                  onSelected: (value) {
                                    widget.genderController.text = value;
                                  },
                                  context: context,
                                  list: userCommonModal!.responseData!.gender!);
                            } else {
                              MySnackBar.showSnackBar(context, "Some Error with Gender Field");
                            }
                          },
                          child: InfoTextFieldWidget(
                            enabled: false,
                            title: MyWrittenText.genderText,
                            textEditingController: widget.genderController,
                            hintText: MyWrittenText.enterGenderText,
                            textInputType: TextInputType.name,
                            suffixIcon: OnTapTextFieldSuffixIconWidget(
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        GestureDetector(
                          onTap: () {
                            if (userCommonModal?.responseData?.gender! != null) {
                              MyBottomSheet.commonUserModalBottomSheet(
                                  fieldSelected: widget.maritalStatusController.text.trim(),
                                  onSelected: (value) {
                                    widget.maritalStatusController.text = value;
                                  },
                                  context: context,
                                  list: userCommonModal!.responseData!.marital!,
                                  heading: 'Marital Status');
                            } else {
                              MySnackBar.showSnackBar(context, "Some Error with Marital Field");
                            }
                          },
                          child: InfoTextFieldWidget(
                            enabled: false,
                            title: MyWrittenText.martialStatusText,
                            textEditingController: widget.maritalStatusController,
                            hintText: MyWrittenText.enterMartialStatusText,
                            textInputType: TextInputType.name,
                            suffixIcon: OnTapTextFieldSuffixIconWidget(
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        widget.relationStatus == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: "${MyWrittenText.contact} 1",
                                    fontSize: 20.h,
                                    color: MyColor.titleTextColor,
                                  ),
                                  SizedBox(height: 6.h),
                                  GestureDetector(
                                    onTap: () {
                                      MyBottomSheet.relationModalBottomSheet(
                                          relationList: RelationModal.relationList,
                                          fieldSelected: widget.empRelationShip1Controller.text.trim(),
                                          context: context,
                                          onSelected: (value) {
                                            widget.empRelationShip1Controller.text = value;
                                          });
                                    },
                                    child: InfoTextFieldWidget(
                                      enabled: false,
                                      title: MyWrittenText.relationshipText,
                                      textEditingController: widget.empRelationShip1Controller,
                                      hintText: MyWrittenText.enterRelationshipText,
                                      textInputType: TextInputType.name,
                                      suffixIcon: OnTapTextFieldSuffixIconWidget(
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  GestureDetector(
                                    onTap: () async {
                                      PhoneContact? singleContact = await getSingleContactPicker();
                                      if (singleContact != null) {
                                        String mobileNumber = singleContact.phoneNumber!.number!;
                                        String cleanedMobileNumber = mobileNumber.replaceAll(RegExp(r'[^0-9]'), '');
                                        widget.relationMobile1Controller.text =
                                            cleanedMobileNumber.substring(cleanedMobileNumber.length - 10);
                                        widget.relationName1Controller.text = singleContact.fullName!;
                                      } else {
                                        MySnackBar.showSnackBar(context, 'Contacts Fetching Error');
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        InfoTextFieldWidget(
                                          enabled: false,
                                          title: MyWrittenText.contactNameText,
                                          textEditingController: widget.relationName1Controller,
                                          hintText: MyWrittenText.enterContactNumberText,
                                          textInputType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                        ),
                                        SizedBox(height: 10.h),
                                        InfoTextFieldWidget(
                                          enabled: false,
                                          title: MyWrittenText.contactNumberText,
                                          textEditingController: widget.relationMobile1Controller,
                                          hintText: MyWrittenText.enterContactNumberText,
                                          textInputType: TextInputType.name,
                                          suffixIcon: OnTapTextFieldSuffixIconWidget(
                                              onPressed: () {}, icon: const Icon(Icons.phone)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  MyText(
                                    text: "${MyWrittenText.contact} 2",
                                    fontSize: 20.h,
                                    color: MyColor.titleTextColor,
                                  ),
                                  SizedBox(height: 6.h),
                                  InkWell(
                                    onTap: () {
                                      MyBottomSheet.relationModalBottomSheet(
                                          relationList: RelationModal.relationList,
                                          fieldSelected: widget.empRelationship2Controller.text.trim(),
                                          context: context,
                                          onSelected: (value) {
                                            widget.empRelationship2Controller.text = value;
                                          });
                                    },
                                    child: InfoTextFieldWidget(
                                      enabled: false,
                                      title: MyWrittenText.relationshipText,
                                      textEditingController: widget.empRelationship2Controller,
                                      hintText: MyWrittenText.enterRelationshipText,
                                      textInputType: TextInputType.name,
                                      suffixIcon: OnTapTextFieldSuffixIconWidget(
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  GestureDetector(
                                    onTap: () async {
                                      PhoneContact? singleContact = await getSingleContactPicker();
                                      if (singleContact != null) {
                                        String mobileNumber = singleContact.phoneNumber!.number!;
                                        String cleanedMobileNumber = mobileNumber.replaceAll(RegExp(r'[^0-9]'), '');
                                        widget.relationMobile2Controller.text =
                                            cleanedMobileNumber.substring(cleanedMobileNumber.length - 10);
                                        widget.relationName2Controller.text = singleContact.fullName!;
                                      } else {
                                        MySnackBar.showSnackBar(context, 'Contacts Fetching Error');
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        InfoTextFieldWidget(
                                          enabled: false,
                                          title: MyWrittenText.contactNameText,
                                          textEditingController: widget.relationName2Controller,
                                          hintText: MyWrittenText.enterContactNumberText,
                                        ),
                                        SizedBox(height: 10.h),
                                        InfoTextFieldWidget(
                                          enabled: false,
                                          title: MyWrittenText.contactNumberText,
                                          textEditingController: widget.relationMobile2Controller,
                                          hintText: MyWrittenText.enterContactNumberText,
                                          textInputType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          suffixIcon: OnTapTextFieldSuffixIconWidget(
                                              onPressed: () {}, icon: const Icon(Icons.phone)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h)
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (MyKeyboardInset.hideWidgetByKeyboard(context))
              BlocListener<UpdateInfoCubit, UpdateInfoState>(
                listener: (context, state) {
                  if (state is UpdatePersonalInfoLoading) {
                    MyScreenLoader.onScreenLoader(context);
                  }
                  if (state is UpdatePersonalInfoError) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.error.toString());
                  }
                  if (state is UpdatePersonalInfoLoaded) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.personalDetailsModal.responseMsg.toString());
                    var cubitProfile = ProfileCubit.get(context);
                    cubitProfile.getProfile();
                    Navigator.pop(context);
                  }
                },
                child: InfoBoxContinueWidget(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var updateCubit = UpdateInfoCubit.get(context);
                    updateCubit.updatePersonalDetails(
                      relationStatus: widget.relationStatus,
                      dob: widget.dobController.text.trim(),
                      alterMobile: widget.alternateNoController.text.trim(),
                      fatherName: widget.fatherNameController.text.trim(),
                      fullName: widget.fullNameController.text.trim(),
                      gender: widget.genderController.text.trim(),
                      martialStatus: widget.maritalStatusController.text.trim(),
                      panNo: widget.panCardController.text.trim(),
                      emRelation1: widget.relationStatus == true ? widget.empRelationShip1Controller.text.trim() : '',
                      emRelation2: widget.relationStatus == true ? widget.empRelationship2Controller.text.trim() : '',
                      relationMobile1:
                          widget.relationStatus == true ? widget.relationMobile1Controller.text.trim() : '',
                      relationMobile2:
                          widget.relationStatus == true ? widget.relationMobile2Controller.text.trim() : '',
                      relationName1: widget.relationStatus == true ? widget.relationName1Controller.text.trim() : '',
                      relationName2: widget.relationStatus == true ? widget.relationName2Controller.text.trim() : '',
                    );
                  }
                }),
              )
          ],
        ),
      ),
    );
  }

  Future<PhoneContact?> getSingleContactPicker() async {
    final PhoneContact contactPicker = await FlutterContactPicker.pickPhoneContact();
    final String contact = contactPicker.fullName!;
    final String phoneNumber = contactPicker.phoneNumber!.number.toString();
    if (contact.isNotEmpty && phoneNumber.isNotEmpty) {
      return contactPicker;
    }
    return null;
  }
}
