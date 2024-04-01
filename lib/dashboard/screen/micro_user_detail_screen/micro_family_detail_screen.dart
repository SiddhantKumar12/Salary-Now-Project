import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/micro_user_save/micro_user_save_cubit.dart';
import 'package:salarynow/dashboard/cubit/religion_cubit/religion_form_cubit.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/validation.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_box_continue_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import '../../../form_helper/network/modal/user_common_modal.dart';
import '../../../registration/cubit/registration_cubit.dart';
import '../../../storage/local_storage.dart';
import '../../../utils/bottom_sheet.dart';
import '../../../utils/color.dart';
import '../../../utils/keyboard_bottom_inset.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/calender_widget.dart';
import '../../../widgets/information_widgets/info_textfield_widget.dart';
import '../../../widgets/onTap_textfield_icon_widget.dart';

class MicroFamilyIncomeScreen extends StatelessWidget {
  MicroFamilyIncomeScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController aadhaarCardController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController incomeOfEarningController = TextEditingController();

  UserCommonModal? userCommonModal = MyStorage.getUserCommonData();
  DashBoardModal? dashBoardModal = MyStorage.getDashBoardData();
  final _formKey = GlobalKey<FormState>();
  String rID = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoCustomAppBar(),
      body: GestureDetector(
        onTap: () => MyKeyboardInset.dismissKeyboard(context),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.h, right: 25.h, top: 10.h),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        const InfoTitleWidget(
                          title: MyWrittenText.familyIncomeTitle,
                          subtitle: MyWrittenText.familyIncomeSubTitle,
                        ),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                          autoFocus: false,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                          title: MyWrittenText.fullNameText,
                          hintText: MyWrittenText.enterNameText,
                          textEditingController: nameController,
                          textInputType: TextInputType.name,
                          maxLength: 20,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.h),
                        BlocBuilder<RegistrationCubit, RegistrationState>(
                          builder: (context, state) {
                            if (state is DatePickerState) {
                              dobController.text = state.selectedDate;
                            }
                            return GestureDetector(
                              onTap: () {
                                MyCalenderWidget.showCalender(context);
                              },
                              child: InfoTextFieldWidget(
                                autoFocus: false,
                                enabled: false,
                                title: MyWrittenText.dOBText,
                                hintText: MyWrittenText.enterDOBText,
                                textEditingController: dobController,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      MyKeyboardInset.dismissKeyboard(context);
                                      MyCalenderWidget.showCalender(context);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      color: MyColor.turcoiseColor,
                                    )),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                        GestureDetector(
                          onTap: () {
                            if (userCommonModal?.responseData?.gender! != null) {
                              MyBottomSheet.commonUserModalBottomSheet(
                                  fieldSelected: maritalStatusController.text.trim(),
                                  onSelected: (value) {
                                    maritalStatusController.text = value;
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
                            textEditingController: maritalStatusController,
                            hintText: MyWrittenText.enterMartialStatusText,
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
                                  fieldSelected: genderController.text.trim(),
                                  heading: 'Gender',
                                  onSelected: (value) {
                                    genderController.text = value;
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
                            textEditingController: genderController,
                            hintText: MyWrittenText.enterGenderText,
                            textInputType: TextInputType.name,
                            suffixIcon: OnTapTextFieldSuffixIconWidget(
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        InfoTextFieldWidget(
                            autoFocus: false,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                            title: MyWrittenText.relationWithBorrower,
                            hintText: MyWrittenText.enterRelationWithBorrower,
                            textEditingController: relationController,
                            validator: (value) => InputValidation.notEmpty(value!)),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                            autoFocus: false,
                            textCapitalization: TextCapitalization.characters,
                            title: MyWrittenText.panCardNoText,
                            hintText: MyWrittenText.enterPanNoText,
                            textEditingController: panCardController,
                            maxLength: 10,
                            validator: (value) => InputValidation.validatePanCard(value!)),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            autoFocus: false,
                            title: MyWrittenText.aadhaarCardNumberText,
                            hintText: MyWrittenText.enterAadhaarCardNumberText,
                            textEditingController: aadhaarCardController,
                            maxLength: 12,
                            validator: (value) => InputValidation.notEmpty(value!)),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                            autoFocus: false,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                            title: MyWrittenText.occupationText,
                            hintText: MyWrittenText.enterOccupationText,
                            textEditingController: occupationController,
                            validator: (value) => InputValidation.notEmpty(value!)),
                        SizedBox(height: 20.h),
                        BlocProvider(
                          create: (context) => ReligionFormCubit(),
                          child: BlocConsumer<ReligionFormCubit, ReligionFormState>(
                            listener: (context, state) {
                              if (state is ReligionFormLoading) {
                                MyScreenLoader.onScreenLoader(context);
                              }
                              if (state is ReligionFormLoaded) {
                                Navigator.pop(context);
                                MyBottomSheet.religionBottomSheet(
                                    fieldSelected: religionController.text.trim(),
                                    context: context,
                                    list: state.modal,
                                    onSelected: (data) {
                                      religionController.text = data;
                                    },
                                    rID: (data) {
                                      rID = data;
                                    },
                                    heading: 'Select Your Religion');
                              }
                              if (state is ReligionFormError) {
                                Navigator.pop(context);
                                MySnackBar.showSnackBar(context, state.error);
                              }
                            },
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  var cubit = ReligionFormCubit.get(context);
                                  cubit.getReligionData();
                                },
                                child: InfoTextFieldWidget(
                                  enabled: false,
                                  autoFocus: false,
                                  title: MyWrittenText.religionText,
                                  hintText: MyWrittenText.enterReligion,
                                  textEditingController: religionController,
                                  suffixIcon: OnTapTextFieldSuffixIconWidget(
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                            autoFocus: false,
                            // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                            title: MyWrittenText.address,
                            hintText: MyWrittenText.enterAddress,
                            textEditingController: addressController,
                            validator: (value) => InputValidation.addressValidation(value!)),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                            autoFocus: false,
                            title: MyWrittenText.pinCodeeText,
                            hintText: MyWrittenText.enterPinCodeText,
                            textEditingController: pinCodeController,
                            textInputType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 6,
                            validator: (value) => InputValidation.notEmpty(value!)),
                        SizedBox(height: 20.h),
                        InfoTextFieldWidget(
                            autoFocus: false,
                            textInputType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            title: MyWrittenText.incomeOfEarning,
                            hintText: MyWrittenText.enterIncomeOfEarning,
                            textEditingController: incomeOfEarningController,
                            textInputAction: TextInputAction.done,
                            maxLength: 10,
                            validator: (value) => InputValidation.salaryChecked(value!)),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
              if (MyKeyboardInset.hideWidgetByKeyboard(context))
                Expanded(
                  flex: 1,
                  child: BlocProvider(
                    create: (context) => MicroUserSaveCubit(),
                    child: BlocConsumer<MicroUserSaveCubit, MicroUserSaveState>(
                      listener: (context, state) {
                        if (state is MicroUserSaveLoading) {
                          MyScreenLoader.onScreenLoader(context);
                        }
                        if (state is MicroUserSaveLoaded) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          MySnackBar.showSnackBar(context, state.modal.responseMsg ?? '');
                        }
                        if (state is MicroUserSaveError) {
                          Navigator.pop(context);
                          MySnackBar.showSnackBar(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        return InfoBoxContinueWidget(
                            onPressed: () {
                              // MyDialogBox.rbi90Days(context: context);
                              if (_formKey.currentState!.validate()) {
                                if (dobController.text.trim().isNotEmpty &&
                                    genderController.text.trim().isNotEmpty &&
                                    maritalStatusController.text.trim().isNotEmpty &&
                                    religionController.text.trim().isNotEmpty) {
                                  /// post function goes here
                                  var cubit = MicroUserSaveCubit.get(context);
                                  cubit.postMicroUserSave(
                                      loanId: dashBoardModal!.responseData!.loanDetails!.applyLoanDataId!,
                                      name: nameController.text.trim(),
                                      dob: dobController.text.trim(),
                                      gender: genderController.text.trim(),
                                      martialStatus: maritalStatusController.text.trim(),
                                      relationBorrower: relationController.text.trim(),
                                      panNumber: panCardController.text.trim(),
                                      aadhaarNumber: aadhaarCardController.text.trim(),
                                      occupation: occupationController.text.trim(),
                                      religion: rID,
                                      address: addressController.text.trim(),
                                      pinCode: pinCodeController.text.trim(),
                                      income: incomeOfEarningController.text.trim());
                                } else if (dobController.text.trim().isEmpty) {
                                  MySnackBar.showSnackBar(context, 'Select Your Date of Birth');
                                } else if (maritalStatusController.text.trim().isEmpty) {
                                  MySnackBar.showSnackBar(context, 'Select Your Marital Status');
                                } else if (genderController.text.trim().isEmpty) {
                                  MySnackBar.showSnackBar(context, 'Select Your Gender');
                                } else if (religionController.text.trim().isEmpty) {
                                  MySnackBar.showSnackBar(context, 'Select Your Religion');
                                }
                              } else {
                                MySnackBar.showSnackBar(context, 'Fill all the details');
                              }
                            },
                            title: 'Submit');
                      },
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
