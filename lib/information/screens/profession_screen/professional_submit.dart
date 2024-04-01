import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salarynow/information/cubit/employment_cubit/loan_emp_cubit.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/registration/network/modal/employment_type.dart';
import '../../../form_helper/form_helper_cubit/form_helper_cubit.dart';
import '../../../form_helper/form_helper_cubit/salary_cubit.dart';
import '../../../form_helper/network/modal/salary_mode.dart';
import '../../../form_helper/network/modal/state_modal.dart';
import '../../../form_helper/network/modal/user_common_modal.dart';
import '../../../storage/local_storage.dart';
import '../../../utils/bottom_sheet.dart';
import '../../../utils/color.dart';
import '../../../utils/keyboard_bottom_inset.dart';
import '../../../utils/on_screen_loader.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/validation.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/calender_widget.dart';
import '../../../widgets/information_widgets/info_box_continue_widget.dart';
import '../../../widgets/information_widgets/info_textfield_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/onTap_textfield_icon_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/update_info_cubit/update_info_cubit.dart';

class ProfessionalInfoSubmit extends StatefulWidget {
  final bool nohitProfileApi;
  String? stateId;
  String? cityId;
  String? salaryModeId;
  String? empId;
  bool? salaryChecked;
  final TextEditingController companyNameController;
  final TextEditingController designationController;
  final TextEditingController companyEmailController;
  // final TextEditingController workingMonthController;
  final TextEditingController companyAddressController;
  final TextEditingController pinCodeController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController salaryController;
  final TextEditingController salaryModeController;
  final TextEditingController educationController;
  final TextEditingController salaryDateController;
  final TextEditingController empTypeController;
  ProfessionalInfoSubmit({
    Key? key,
    required this.companyNameController,
    required this.designationController,
    required this.companyEmailController,
    // required this.workingMonthController,
    required this.companyAddressController,
    required this.pinCodeController,
    required this.cityController,
    required this.stateController,
    required this.salaryController,
    required this.salaryModeController,
    required this.educationController,
    required this.salaryDateController,
    required this.stateId,
    required this.cityId,
    required this.salaryModeId,
    required this.nohitProfileApi,
    required this.empTypeController,
    this.empId,
    this.salaryChecked,
  }) : super(key: key);

  @override
  State<ProfessionalInfoSubmit> createState() => _ProfessionalInfoSubmitState();
}

class _ProfessionalInfoSubmitState extends State<ProfessionalInfoSubmit> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController textEditingController = TextEditingController();

  UserCommonModal? userCommonModal = MyStorage.getUserCommonData();
  StateModal? stateModal = MyStorage.getStateData();
  SalaryModal? salaryModal = MyStorage.getSalaryMode();
  EmploymentTypeModal? employmentTypeModal = MyStorage.getEmploymentType();
  final nameRegex = RegExp(r'^[a-zA-Z ]+$');
  final numberRegex = RegExp(r'^\d+$');

  String? validateNameField(String value, String validName) {
    if (value.isEmpty) {
      return "Please Fill This Field"; // Name is empty
    }
    if (!nameRegex.hasMatch(value)) {
      return "Enter Valid $validName"; // Name contains invalid characters
    }
    return null;
  }

  String? validateNumber(String value, String validName) {
    if (value.isEmpty) {
      return "Please Fill This Field"; // Number is empty
    }
    if (!numberRegex.hasMatch(value)) {
      return "Enter Valid $validName"; // Name contains invalid characters
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyKeyboardInset.dismissKeyboard(context),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InfoTitleWidget(
                        subtitle: MyWrittenText.pleaseSubtitleText,
                        title: MyWrittenText.professionalInfoText,
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          InfoTextFieldWidget(
                            title: MyWrittenText.companyNameText,
                            textEditingController: widget.companyNameController,
                            hintText: MyWrittenText.enterCompanyNameText,
                            validator: (value) =>
                                validateNameField(widget.companyNameController.text.trim(), "Company Name"),
                          ),
                          SizedBox(height: 15.h),
                          InfoTextFieldWidget(
                              autoFocus: false,
                              title: MyWrittenText.designationText,
                              textEditingController: widget.designationController,
                              hintText: MyWrittenText.enterDesignationText,
                              validator: (value) =>
                                  validateNameField(widget.designationController.text.trim(), "Designation Name")),
                          SizedBox(height: 15.h),
                          InfoTextFieldWidget(
                              title: MyWrittenText.companyEmailIDText,
                              textEditingController: widget.companyEmailController,
                              hintText: MyWrittenText.enterCompanyEmailIDText,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (!EmailValidator.validate(value!)) {
                                  return "Enter Correct Email";
                                }
                                return null;
                              }),
                          SizedBox(height: 15.h),
                          // InfoTextFieldWidget(
                          //     maxLength: 4,
                          //     title: MyWrittenText.workingMonthText,
                          //     textEditingController: widget.workingMonthController,
                          //     hintText: MyWrittenText.enterWorkingMonthText,
                          //     textInputType: TextInputType.number,
                          //     validator: (value) {
                          //       RegExp regExp = RegExp(r'^0.*');
                          //       if (widget.workingMonthController.text.trim().isEmpty) {
                          //         return 'This Field is Empty';
                          //       } else if (regExp.hasMatch(widget.workingMonthController.text)) {
                          //         return 'Enter Correct Month';
                          //       } else {
                          //         return null;
                          //       }
                          //     }),
                          SizedBox(height: 15.h),
                          InfoTextFieldWidget(
                              title: MyWrittenText.companyAddressText,
                              textEditingController: widget.companyAddressController,
                              hintText: MyWrittenText.enterCompanyAddressText,
                              validator: (value) =>
                                  InputValidation.addressValidation(widget.companyAddressController.text)),
                          SizedBox(height: 15.h),
                          BlocListener<FormHelperApiCubit, FormHelperApiState>(
                            listener: (context, state) {
                              if (state is PinCodeeLoadedState) {
                                widget.pinCodeController.text = state.pinCodeModal.responseData!.pincode!;
                                widget.cityController.text = state.pinCodeModal.responseData!.city!;
                                widget.stateController.text = state.pinCodeModal.responseData!.state!;
                                widget.stateId = state.pinCodeModal.responseData!.stateId!;
                                widget.cityId = state.pinCodeModal.responseData!.cityId!;
                              }
                            },
                            child: InfoTextFieldWidget(
                                title: MyWrittenText.pinCodeeText,
                                textEditingController: widget.pinCodeController,
                                hintText: MyWrittenText.enterPinCodeText,
                                textInputType: TextInputType.number,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                validator: (value) {
                                  if (value!.length != 6) {
                                    return "Enter Pin Code";
                                  } else if (value.length != 6) {
                                    return "Empty";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  if (value.length == 6) {
                                    context.read<FormHelperApiCubit>().postPinCode(pinCode: value);
                                  } else {
                                    widget.stateController.clear();
                                    widget.cityController.clear();
                                  }
                                }),
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                              onTap: () {
                                if (stateModal != null) {
                                  MyBottomSheet.stateListSheetWidget(
                                      fieldSelected: widget.stateController.text.trim(),
                                      stateCode: (value) {
                                        widget.stateId = value;
                                        widget.cityId = '';
                                        widget.cityController.text = '';
                                      },
                                      onSelected: (value) {
                                        widget.stateController.text = value;
                                      },
                                      context: context,
                                      stateList: stateModal!);
                                } else {
                                  MySnackBar.showSnackBar(context, 'Some Error on State Field');
                                }
                              },
                              child: InfoTextFieldWidget(
                                enabled: false,
                                title: MyWrittenText.stateText,
                                textEditingController: widget.stateController,
                                hintText: MyWrittenText.enterStateText,
                                suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                              )),
                          SizedBox(height: 15.h),
                          BlocListener<FormHelperApiCubit, FormHelperApiState>(
                            listener: (context, state) {
                              if (state is CityLoadingState) {
                                MyScreenLoader.onScreenLoader(context);
                              }
                              if (state is CityLoadedState) {
                                Navigator.pop(context);
                                MyBottomSheet.cityListSheetWidget(
                                    fieldSelected: widget.cityController.text.trim(),
                                    cityCode: (value) {
                                      widget.cityId = value;
                                    },
                                    onSelected: (value) {
                                      widget.cityController.text = value;
                                    },
                                    context: context,
                                    cityModal: state.cityModal);
                              }
                              if (state is CityErrorState) {
                                Navigator.pop(context);
                                MySnackBar.showSnackBar(context, state.error);
                              }
                            },
                            child: GestureDetector(
                                onTap: () {
                                  var cubit = FormHelperApiCubit.get(context);
                                  cubit.postCity(stateId: widget.stateId);
                                },
                                child: InfoTextFieldWidget(
                                  enabled: false,
                                  title: MyWrittenText.cityText,
                                  textEditingController: widget.cityController,
                                  hintText: MyWrittenText.enterCityText,
                                  suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                )),
                          ),
                          SizedBox(height: 15.h),
                          BlocBuilder<SalaryCubit, bool>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  InfoTextFieldWidget(
                                      autoFocus: false,
                                      maxLength: 7,
                                      title: MyWrittenText.salaryText,
                                      textEditingController: widget.salaryController,
                                      textInputType: TextInputType.phone,
                                      hintText: MyWrittenText.enterSalaryText,
                                      validator: (value) {
                                        RegExp regExp = RegExp(r'^0.*');
                                        if (widget.salaryController.text.trim().isEmpty) {
                                          return 'This Field is Empty';
                                        } else if (regExp.hasMatch(widget.salaryController.text)) {
                                          return 'Enter Correct Amount';
                                        } else {
                                          double salary = double.parse(widget.salaryController.text.trim());
                                          context.read<SalaryCubit>().checkApprovalStatus(salary);
                                        }
                                        return null;
                                      }),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 15.h),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (userCommonModal?.responseData?.qualification! != null) {
                                    MyBottomSheet.educationBottomSheet(
                                        fieldSelected: widget.educationController.text.trim(),
                                        context: context,
                                        qualification: userCommonModal!.responseData!.qualification!,
                                        onSelected: (data) {
                                          widget.educationController.text = data;
                                        });
                                  } else {
                                    MySnackBar.showSnackBar(context, "Some Error with Gender Field");
                                  }
                                },
                                child: InfoTextFieldWidget(
                                  enabled: false,
                                  title: MyWrittenText.educationText,
                                  textEditingController: widget.educationController,
                                  hintText: MyWrittenText.enterEduText,
                                  suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: () {
                              if (salaryModal != null) {
                                MyBottomSheet.salaryBottomSheet(
                                    fieldSelected: widget.salaryModeController.text.trim(),
                                    context: context,
                                    salaryModal: salaryModal!,
                                    salaryCode: (value) {
                                      widget.salaryModeId = value;
                                    },
                                    onSelected: (value) {
                                      widget.salaryModeController.text = value;
                                    });
                              } else {
                                MySnackBar.showSnackBar(context, "Error with salary Mode Field");
                              }
                            },
                            child: InfoTextFieldWidget(
                              enabled: false,
                              title: MyWrittenText.modeOfSalaryText,
                              textEditingController: widget.salaryModeController,
                              hintText: MyWrittenText.enterModeSalaryText,
                              suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          BlocListener<FormHelperApiCubit, FormHelperApiState>(
                            listener: (context, state) {
                              if (state is DatePickerLoaded) {
                                widget.salaryDateController.text = state.selectedDate;
                                // widget.salaryDateController.text = getDate()!;
                              }
                            },
                            child: GestureDetector(
                              onTap: () {
                                MyCalenderWidget.showSalaryCalender(context);
                              },
                              child: InfoTextFieldWidget(
                                enabled: false,
                                title: MyWrittenText.salaryDateText,
                                textEditingController: widget.salaryDateController,
                                hintText: MyWrittenText.enterSalaryDateText,
                                textInputAction: TextInputAction.done,
                                suffixIcon: const Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: () {
                              if (employmentTypeModal != null) {
                                MyBottomSheet.empTypeSheet(
                                    fieldSelected: widget.empTypeController.text.trim(),
                                    context: context,
                                    employmentTypeModal: employmentTypeModal!,
                                    empId: (value) {
                                      widget.empId = value;
                                    },
                                    onSelected: (value) {
                                      widget.empTypeController.text = value;
                                    });
                              } else {
                                MySnackBar.showSnackBar(context, "Error with Employment Type Field");
                              }
                            },
                            child: InfoTextFieldWidget(
                              enabled: false,
                              title: MyWrittenText.employmentTypeText,
                              textEditingController: widget.empTypeController,
                              hintText: MyWrittenText.enterModeSalaryText,
                              suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          BlocBuilder<SalaryCubit, bool>(
                            builder: (context, state) {
                              if (state == false) {
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Theme(
                                          data: ThemeData(
                                            unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                                          ),
                                          child: SizedBox(
                                              height: 20.h,
                                              width: 20.w,
                                              child: Checkbox(
                                                value: widget.salaryChecked,
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.salaryChecked = value!;
                                                  });
                                                },
                                              ))),
                                      SizedBox(width: 10.w),
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (widget.salaryChecked!) {
                                              widget.salaryChecked = false;
                                            } else {
                                              widget.salaryChecked = true;
                                            }
                                            setState(() {});
                                          },
                                          child: MyText(
                                            text: MyWrittenText.salaryCondition,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      )
                                    ]);
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (MyKeyboardInset.hideWidgetByKeyboard(context))
              BlocListener<UpdateInfoCubit, UpdateInfoState>(
                listener: (context, state) {
                  if (state is UpdateEmpDetailLoading) {
                    MyScreenLoader.onScreenLoader(context);
                  }
                  if (state is UpdateEmpDetailError) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.error.toString());
                  }
                  if (state is UpdateEmpDetailLoaded) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.empDetailModal.responseMsg.toString());
                    if (widget.nohitProfileApi == true) {
                      var loanEmpCubit = LoanEmpCubit.get(context);
                      loanEmpCubit.getEmpDetails();
                    } else {
                      var cubit = ProfileCubit.get(context);
                      cubit.getProfile();
                    }
                    Navigator.pop(context);
                  }
                },
                child: InfoBoxContinueWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var updateCubit = UpdateInfoCubit.get(context);
                      updateCubit.updateEmpDetails(
                        companyName: widget.companyNameController.text.trim(),
                        designation: widget.designationController.text.trim(),
                        salary: widget.salaryController.text.trim(),
                        salaryMode: widget.salaryModeId,
                        officeAddress: widget.companyAddressController.text.trim(),
                        officeCityId: widget.cityId,
                        officeStateId: widget.stateId,
                        officePinCode: widget.pinCodeController.text.trim(),
                        salaryDate: widget.salaryDateController.text.trim(),
                        education: widget.educationController.text.trim(),
                        workingEmail: widget.companyEmailController.text.trim(),
                        // noMonthWork: widget.workingMonthController.text.trim(),
                        empType: widget.empId,
                        salaryChecked: widget.salaryChecked,
                      );
                    } else {
                      MySnackBar.showSnackBar(context, "Fill Your Details Correctly");
                    }
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  String? getDate() {
    DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(widget.salaryDateController.text);
    String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    return formattedDate;
  }
}
