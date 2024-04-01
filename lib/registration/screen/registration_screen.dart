import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:salarynow/permission_handler/cubit/all_permission_cubit/permission_cubit.dart';
import 'package:salarynow/registration/cubit/pan_card_validation/pan_card_validation_cubit.dart';
import 'package:salarynow/registration/cubit/registration_cubit.dart';
import 'package:salarynow/utils/bottom_sheet.dart';
import 'package:salarynow/utils/lottie.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/calender_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_box_continue_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_textfield_widget.dart';
import 'package:salarynow/widgets/onTap_textfield_icon_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../routing/route_path.dart';
import '../../utils/color.dart';
import '../../utils/keyboard_bottom_inset.dart';
import '../../utils/snackbar.dart';
import '../../widgets/dialog_box_widget.dart';
import 'package:salarynow/storage/local_storage.dart';
import 'package:salarynow/storage/local_storage_strings.dart';

class RegistrationScreen extends StatefulWidget {
  final String mobileNumber;
  const RegistrationScreen({Key? key, this.mobileNumber = ""}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  static final RegExp notNameRegExp = RegExp('[a-zA-Z]');
  static final RegExp nameRegExp = RegExp('[0-9]');
  static final RegExp noSpecialChar = RegExp("!^[`~!@#%^&*()-_=]+\$");
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController employmentController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  String? imei = MyStorage.readData(MyStorageString.imei);

  @override
  void initState() {
    super.initState();
    var cubit = PermissionCubit.get(context);
    cubit.reqLocationPermission();
  }

  String stateId = "";
  String cityId = "";
  String empId = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationErrorState) {
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, state.error.toString());
        }
        if (state is RegistrationLoadingState) {
          MyScreenLoader.onScreenLoader(context);
        }
        if (state is RegistrationLoadedState) {
          Navigator.pop(context);

          MyStorage.writeData(MyStorageString.userLoggedIn, true);

          MyDialogBox.successfulRegistration(
              context: context,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, RoutePath.botNavBar, (route) => false);
                // Navigator.pushReplacementNamed(context, RoutePath.permissionScreen, arguments: false);
              });
        }
        if (state is PinCodeLoadingState) {
          MyScreenLoader.onScreenLoader(context);
        }
        if (state is PinCodeErrorState) {
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, state.error.toString());
        }
        if (state is PinCodeLoadedState) {
          Navigator.pop(context);
          MyKeyboardInset.dismissKeyboard(context);
          stateController.text = state.pinCodeModal.responseData!.state.toString();
          stateId = state.pinCodeModal.responseData!.stateId!;
          cityController.text = state.pinCodeModal.responseData!.city.toString();
          cityId = state.pinCodeModal.responseData!.cityId!;
        }

        /// state

        if (state is StateLoadingState) {
          MyScreenLoader.onScreenLoader(context);
        }
        if (state is StateLoadedState) {
          Navigator.pop(context);
          MyBottomSheet.stateListSheetWidget(
              fieldSelected: stateController.text.trim(),
              stateCode: (value) {
                stateId = value;
                cityId = '';
                cityController.text = '';
              },
              onSelected: (value) {
                stateController.text = value;
              },
              context: context,
              stateList: state.stateModal);
        }
        if (state is StateErrorState) {
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, state.error);
        }

        /// city

        if (state is CityLoadingState) {
          MyScreenLoader.onScreenLoader(context);
        }
        if (state is CityLoadedState) {
          Navigator.pop(context);
          MyBottomSheet.cityListSheetWidget(
              fieldSelected: cityController.text.trim(),
              cityCode: (value) {
                cityId = value;
              },
              onSelected: (value) {
                cityController.text = value;
              },
              context: context,
              cityModal: state.cityModal);
        }
        if (state is CityErrorState) {
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, state.error);
        }

        /// Employment
        if (state is EmpLoadingState) {
          MyScreenLoader.onScreenLoader(context);
        }
        if (state is EmpTypeErrorState) {
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, state.error.toString());
        }

        if (state is EmpTypeLoadedState) {
          Navigator.pop(context);
          MyKeyboardInset.dismissKeyboard(context);
          MyBottomSheet.empTypeSheet(
            fieldSelected: employmentController.text,
            context: context,
            employmentTypeModal: state.employmentTypeModal,
            onSelected: (value) {
              employmentController.text = value;
            },
            empId: (value) {
              empId = value;
            },
          );
        }
      },
      builder: (context, state) {
        mobileNoController.text = widget.mobileNumber;
        return SafeArea(
          child: Scaffold(
            appBar: const InfoCustomAppBar(
              title: MyWrittenText.registrationText,
              leading: null,
            ),
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
              onTap: () => MyKeyboardInset.dismissKeyboard(context),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 10.h,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    BlocListener<PanCardValidationCubit, PanCardValidationState>(
                                      listener: (context, state) {
                                        if (state is PanCardValidationLoading) {
                                          MyScreenLoader.onScreenLoader(context);
                                        }
                                        if (state is PanCardValidationLoaded) {
                                          Navigator.pop(context);
                                          nameController.text = state.panCardModal.responseData!.data!.fullName!;
                                        }
                                        if (state is PanCardValidationError) {
                                          Navigator.pop(context);
                                          MySnackBar.showSnackBar(context, state.error);
                                        }
                                      },
                                      child: InfoTextFieldWidget(
                                          autoFocus: false,
                                          textCapitalization: TextCapitalization.characters,
                                          title: MyWrittenText.panCardNoText,
                                          hintText: MyWrittenText.enterPanNoText,
                                          textEditingController: panCardController,
                                          maxLength: 10,
                                          onChanged: (value) {
                                            String pattern = r'^[A-Z]{3}[P]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$';
                                            RegExp regExp = RegExp(pattern);

                                            if (!regExp.hasMatch(value)) {
                                              return nameController.clear();
                                            } else if (value.length == 10) {
                                              var cubit = PanCardValidationCubit.get(context);
                                              cubit.postPinCode(panCard: value);
                                            } else {
                                              nameController.clear();
                                            }
                                          },
                                          validator: (value) => validatePanCard(value!)),
                                    ),
                                    SizedBox(height: 20.h),
                                    InfoTextFieldWidget(
                                      // enabled: false,
                                      title: MyWrittenText.fullNameText,
                                      hintText: MyWrittenText.enterNameText,
                                      textEditingController: nameController,
                                      textInputType: TextInputType.name,
                                      maxLength: 20,
                                      textCapitalization: TextCapitalization.characters,
                                    ),
                                    SizedBox(height: 20.h),
                                    InfoTextFieldWidget(
                                        fillColor: MyColor.textFieldFillColor,
                                        enabled: false,
                                        title: MyWrittenText.mobileNoText,
                                        hintText: MyWrittenText.enterMobileNoText,
                                        textEditingController: mobileNoController,
                                        textInputType: TextInputType.number,
                                        validator: (value) {
                                          return null;
                                        },
                                        suffixIcon: Transform.scale(
                                            scale: 0.75,
                                            child: Lottie.asset(MyLottie.tickSuccessLottie, height: 4.h, width: 4.w))),
                                    SizedBox(height: 20.h),
                                    InfoTextFieldWidget(
                                        title: MyWrittenText.emailIDText,
                                        hintText: MyWrittenText.enterEmailText,
                                        textEditingController: emailController,
                                        validator: (value) {
                                          if (!EmailValidator.validate(value!)) {
                                            return "Enter Correct Email";
                                          }
                                          return null;
                                        }),
                                    SizedBox(height: 20.h),
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
                                            enabled: false,
                                            title: MyWrittenText.dOBText,
                                            hintText: MyWrittenText.enterDOBText,
                                            textEditingController: dobController,
                                            suffixIcon: IconButton(
                                                onPressed: () {
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
                                    SizedBox(height: 20.h),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: MyText(
                                        text: MyWrittenText.currentAddressText,
                                        fontSize: 22.sp,
                                        color: MyColor.titleTextColor,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    InfoTextFieldWidget(
                                        autoFocus: false,
                                        title: MyWrittenText.pinCodeText,
                                        hintText: MyWrittenText.selectCodeText,
                                        textEditingController: pinCodeController,
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
                                            MyKeyboardInset.dismissKeyboard(context);
                                            context.read<RegistrationCubit>().postPinCode(pinCode: value);
                                          } else {
                                            stateController.clear();
                                            cityController.clear();
                                          }
                                        }),
                                    SizedBox(height: 20.h),
                                    GestureDetector(
                                      onTap: () {
                                        MyKeyboardInset.dismissKeyboard(context);
                                        context.read<RegistrationCubit>().getState();
                                      },
                                      child: InfoTextFieldWidget(
                                        enabled: false,
                                        title: MyWrittenText.stateText,
                                        hintText: MyWrittenText.selectStateText,
                                        textEditingController: stateController,
                                        validator: (value) {
                                          if (state is PinCodeLoadedState) {
                                            if (stateController.text.isEmpty) {
                                              return "Fill the details";
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    GestureDetector(
                                      onTap: () {
                                        MyKeyboardInset.dismissKeyboard(context);
                                        context.read<RegistrationCubit>().postCity(stateId: stateId);
                                      },
                                      child: InfoTextFieldWidget(
                                        enabled: false,
                                        title: MyWrittenText.cityText,
                                        hintText: MyWrittenText.selectCityText,
                                        textEditingController: cityController,
                                        validator: (value) {
                                          if (state is PinCodeLoadedState) {
                                            if (cityController.text.isEmpty) {
                                              return "Fill the details";
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<RegistrationCubit>().getEmploymentType();
                                      },
                                      child: InfoTextFieldWidget(
                                        enabled: false,
                                        title: MyWrittenText.employmentTypeText,
                                        textEditingController: employmentController,
                                        hintText: MyWrittenText.selectEmploymentText,
                                        textInputAction: TextInputAction.done,
                                        suffixIcon: const OnTapTextFieldSuffixIconWidget(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (MyKeyboardInset.hideWidgetByKeyboard(context))
                      InfoBoxContinueWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (employmentController.text.trim().isNotEmpty) {
                              context.read<RegistrationCubit>().registerUser(
                                  name: nameController.text.trim(),
                                  pinCode: pinCodeController.text.trim(),
                                  mobile: mobileNoController.text.trim(),
                                  stateLocation: stateId,
                                  cityLocation: cityId,
                                  dob: dobController.text.trim(),
                                  email: emailController.text.trim(),
                                  employmentType: empId,
                                  panCardNo: panCardController.text.trim(),
                                  imei: imei ?? '');
                            } else {
                              MySnackBar.showSnackBar(context, 'Please Fill Employment Type');
                            }
                          }
                        },
                        title: MyWrittenText.register,
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validatePanCard(String value) {
    String pattern = r'^[A-Z]{3}[P]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please Enter Pancard Number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Pancard Number';
    }
    // } else if (value.length == 10) {
    //   // PanCardValidationCubit.get(context).postPinCode(panCard: value);
    //   print('hit api');
    //   return null;
    // }
    return null;
  }
}
