import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import '../../../form_helper/form_helper_cubit/form_helper_cubit.dart';
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
import '../../../widgets/dialog_box_widget.dart';
import '../../../widgets/divider_widget.dart';
import '../../../widgets/information_widgets/info_box_continue_widget.dart';
import '../../../widgets/information_widgets/info_textfield_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/onTap_textfield_icon_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/residential_cubit/aadhaar_card_otp/aadhaar_card_otp_cubit.dart';
import '../../cubit/residential_cubit/aadhaar_card_verification/aadhaar_card_verification_cubit.dart';
import '../../cubit/update_info_cubit/update_info_cubit.dart';

class ResidentialIntoSubmit extends StatefulWidget {
  String? currentCityId;
  String? currentStateId;
  String? perCityId;
  String? perStateId;
  final TextEditingController accommodationTypeController;
  final TextEditingController nearLandmarkTypeController;
  final TextEditingController currentAddressTypeController;
  final TextEditingController currentStateController;
  final TextEditingController currentCityTypeController;
  final TextEditingController currentPinCodeTypeController;
  final TextEditingController permanentAddressController;
  final TextEditingController permanentCityController;
  final TextEditingController permanentStateController;
  final TextEditingController permanentPinCodeTypeController;
  ResidentialIntoSubmit(
      {Key? key,
      required this.accommodationTypeController,
      required this.nearLandmarkTypeController,
      required this.currentAddressTypeController,
      required this.currentStateController,
      required this.currentCityTypeController,
      required this.currentPinCodeTypeController,
      required this.permanentAddressController,
      required this.permanentCityController,
      required this.permanentStateController,
      required this.permanentPinCodeTypeController,
      this.perCityId,
      this.perStateId,
      this.currentCityId,
      this.currentStateId})
      : super(key: key);

  @override
  State<ResidentialIntoSubmit> createState() => _ResidentialIntoSubmitState();
}

class _ResidentialIntoSubmitState extends State<ResidentialIntoSubmit> {
  bool isSameResident = false;
  bool isPerPinCode = false;
  bool isPerState = false;
  bool isPerCity = false;
  final _formKey = GlobalKey<FormState>();
  UserCommonModal? userCommonModal = MyStorage.getUserCommonData();
  StateModal? stateModal = MyStorage.getStateData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => MyKeyboardInset.dismissKeyboard(context),
        child: Form(
            key: _formKey,
            child: Column(children: [
              Expanded(
                  flex: 13,
                  child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const InfoTitleWidget(
                                title: MyWrittenText.residentialAdd,
                                subtitle: MyWrittenText.pleaseSubtitleText,
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: MyWrittenText.currentAdd,
                                    fontSize: 20.sp,
                                    color: MyColor.titleTextColor,
                                  ),
                                  const SizedBox(height: 12),
                                  GestureDetector(
                                    onTap: () {
                                      if (userCommonModal?.responseData?.accomadation != null) {
                                        MyBottomSheet.commonUserModalBottomSheet(
                                            fieldSelected: widget.accommodationTypeController.text.trim(),
                                            heading: 'Utility',
                                            context: context,
                                            list: userCommonModal!.responseData!.accomadation!,
                                            onSelected: (value) => widget.accommodationTypeController.text = value);
                                      } else {
                                        MySnackBar.showSnackBar(context, "Some Error with Gender Field");
                                      }
                                    },
                                    child: InfoTextFieldWidget(
                                      enabled: false,
                                      title: MyWrittenText.accommodationType,
                                      textEditingController: widget.accommodationTypeController,
                                      hintText: MyWrittenText.enterAccommodationType,
                                      textInputType: TextInputType.name,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  InfoTextFieldWidget(
                                    title: MyWrittenText.nearLandmark,
                                    textEditingController: widget.nearLandmarkTypeController,
                                    hintText: MyWrittenText.enterNearLandmark,
                                    textInputType: TextInputType.name,
                                    validator: (value) =>
                                        InputValidation.addressValidation(widget.nearLandmarkTypeController.text),
                                  ),
                                  SizedBox(height: 15.h),
                                  InfoTextFieldWidget(
                                      title: MyWrittenText.address,
                                      textEditingController: widget.currentAddressTypeController,
                                      hintText: MyWrittenText.enterAddress,
                                      textInputType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) =>
                                          InputValidation.addressValidation(widget.currentAddressTypeController.text)),
                                  SizedBox(height: 15.h),
                                  BlocListener<FormHelperApiCubit, FormHelperApiState>(
                                    listener: (context, state) {
                                      if (state is PinCodeeLoadedState) {
                                        if (isPerPinCode == false) {
                                          var data = state.pinCodeModal.responseData;
                                          widget.currentCityTypeController.text = data!.city!;
                                          widget.currentStateController.text = data.state!;
                                          widget.currentCityId = data.cityId;
                                          widget.currentStateId = data.stateId;
                                        }
                                      }
                                    },
                                    child: InfoTextFieldWidget(
                                        autoFocus: false,
                                        title: MyWrittenText.pinCodeeText,
                                        textEditingController: widget.currentPinCodeTypeController,
                                        hintText: MyWrittenText.enterPinCodeText,
                                        textInputType: TextInputType.number,
                                        validator: (value) =>
                                            InputValidation.notEmpty(widget.currentPinCodeTypeController.text.trim()),
                                        onChanged: (value) {
                                          if (value.length == 6) {
                                            isPerPinCode = false;
                                            context.read<FormHelperApiCubit>().postPinCode(pinCode: value);
                                          } else {
                                            widget.currentStateController.clear();
                                            widget.currentCityTypeController.clear();
                                          }
                                        }),
                                  ),
                                  SizedBox(height: 15.h),
                                  GestureDetector(
                                    onTap: () {
                                      if (stateModal != null) {
                                        MyBottomSheet.stateListSheetWidget(
                                            fieldSelected: widget.currentStateController.text.trim(),
                                            stateCode: (value) {
                                              widget.currentStateId = value;

                                              widget.currentCityId = '';

                                              widget.currentCityTypeController.text = '';
                                            },
                                            onSelected: (value) {
                                              widget.currentStateController.text = value;
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
                                      textEditingController: widget.currentStateController,
                                      hintText: MyWrittenText.enterState,
                                      suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                      textInputType: TextInputType.name,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  BlocListener<FormHelperApiCubit, FormHelperApiState>(
                                    listener: (context, state) {
                                      if (state is CityLoadingState) {
                                        MyScreenLoader.onScreenLoader(context);
                                      }
                                      if (state is CityErrorState) {
                                        Navigator.pop(context);
                                        MySnackBar.showSnackBar(context, state.error);
                                      }
                                      if (state is CityLoadedState) {
                                        Navigator.pop(context);
                                        MyBottomSheet.cityListSheetWidget(
                                            cityCode: (value) {
                                              widget.currentCityId = value;
                                            },
                                            onSelected: (value) {
                                              widget.currentCityTypeController.text = value;
                                            },
                                            context: context,
                                            cityModal: state.cityModal,
                                            fieldSelected: widget.currentCityTypeController.text.trim());
                                      }
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        var cubit = FormHelperApiCubit.get(context);
                                        cubit.postCity(stateId: widget.currentStateId, secondCity: false);
                                      },
                                      child: InfoTextFieldWidget(
                                        enabled: false,
                                        title: MyWrittenText.cityText,
                                        textEditingController: widget.currentCityTypeController,
                                        hintText: MyWrittenText.enterCity,
                                        textInputType: TextInputType.name,
                                        suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    child: MyDivider(color: MyColor.subtitleTextColor.withOpacity(0.5)),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      MyText(
                                        text: MyWrittenText.permanentAdd,
                                        fontSize: 20.sp,
                                        color: MyColor.titleTextColor,
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                        Theme(
                                            data: ThemeData(
                                              unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                                            ),
                                            child: SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child: Checkbox(
                                                  value: isSameResident,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isSameResident = value!;
                                                    });
                                                  },
                                                ))),
                                        SizedBox(width: 10.w),
                                        GestureDetector(
                                          onTap: () {
                                            if (isSameResident) {
                                              isSameResident = false;
                                            } else {
                                              isSameResident = true;
                                            }
                                            setState(() {});
                                          },
                                          child: MyText(
                                            text: MyWrittenText.sameAsCurrentAdd,
                                            fontSize: 12.sp,
                                          ),
                                        )
                                      ]),
                                      isSameResident == true
                                          ? const SizedBox()
                                          : Column(children: [
                                              SizedBox(height: 25.h),
                                              InfoTextFieldWidget(
                                                  title: MyWrittenText.address,
                                                  textEditingController: widget.permanentAddressController,
                                                  hintText: MyWrittenText.enterAddress,
                                                  textInputType: TextInputType.name,
                                                  validator: (value) => InputValidation.addressValidation(
                                                      widget.permanentAddressController.text)),
                                              SizedBox(height: 15.h),
                                              BlocListener<FormHelperApiCubit, FormHelperApiState>(
                                                listener: (context, state) {
                                                  if (state is PinCodeeLoadedState) {
                                                    if (isPerPinCode) {
                                                      var data = state.pinCodeModal.responseData;
                                                      widget.permanentCityController.text = data!.city!;
                                                      widget.permanentStateController.text = data.state!;
                                                      widget.perCityId = data.cityId;
                                                      widget.perStateId = data.stateId;
                                                    }
                                                    isPerPinCode = false;
                                                  }
                                                },
                                                child: InfoTextFieldWidget(
                                                    autoFocus: false,
                                                    title: MyWrittenText.pinCodeeText,
                                                    textEditingController: widget.permanentPinCodeTypeController,
                                                    hintText: MyWrittenText.enterPinCodeText,
                                                    textInputType: TextInputType.number,
                                                    validator: (value) => InputValidation.notEmpty(
                                                        widget.permanentPinCodeTypeController.text.trim()),
                                                    onChanged: (value) {
                                                      if (widget.permanentPinCodeTypeController.text.trim().length ==
                                                          6) {
                                                        isPerPinCode = true;
                                                        context.read<FormHelperApiCubit>().postPinCode(
                                                            pinCode: widget.permanentPinCodeTypeController.text.trim());
                                                      } else {
                                                        widget.permanentStateController.clear();
                                                        widget.permanentCityController.clear();
                                                      }
                                                    }),
                                              ),
                                              SizedBox(height: 15.h),
                                              GestureDetector(
                                                onTap: () {
                                                  if (stateModal != null) {
                                                    MyBottomSheet.stateListSheetWidget(
                                                        fieldSelected: widget.permanentStateController.text.trim(),
                                                        stateCode: (value) {
                                                          widget.perStateId = value;

                                                          widget.perCityId = '';
                                                          widget.permanentCityController.text = '';
                                                        },
                                                        onSelected: (value) {
                                                          widget.permanentStateController.text = value;
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
                                                  textEditingController: widget.permanentStateController,
                                                  hintText: MyWrittenText.enterState,
                                                  textInputType: TextInputType.name,
                                                  suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                                ),
                                              ),
                                              SizedBox(height: 15.h),
                                              BlocListener<FormHelperApiCubit, FormHelperApiState>(
                                                listener: (context, state) {
                                                  if (state is SecondCityLoadingState) {
                                                    MyScreenLoader.onScreenLoader(context);
                                                  }
                                                  if (state is SecondCityLoadedState) {
                                                    Navigator.pop(context);
                                                    MyBottomSheet.cityListSheetWidget(
                                                        fieldSelected: widget.permanentStateController.text.trim(),
                                                        cityCode: (value) {
                                                          widget.perCityId = value;
                                                        },
                                                        onSelected: (value) {
                                                          widget.permanentCityController.text = value;
                                                        },
                                                        context: context,
                                                        cityModal: state.cityModal);
                                                  }
                                                  if (state is SecondCityErrorState) {
                                                    Navigator.pop(context);
                                                    MySnackBar.showSnackBar(context, state.error);
                                                  }
                                                },
                                                child: GestureDetector(
                                                  onTap: () {
                                                    var cubit = FormHelperApiCubit.get(context);
                                                    cubit.postCity(stateId: widget.perStateId, secondCity: true);
                                                  },
                                                  child: InfoTextFieldWidget(
                                                    enabled: false,
                                                    title: MyWrittenText.cityText,
                                                    textEditingController: widget.permanentCityController,
                                                    hintText: MyWrittenText.enterCity,
                                                    textInputType: TextInputType.name,
                                                    suffixIcon: OnTapTextFieldSuffixIconWidget(onPressed: () {}),
                                                    textInputAction: TextInputAction.done,
                                                  ),
                                                ),
                                              ),
                                            ])
                                    ])
                                  ])
                                ],
                              )
                            ],
                          )))),
              if (MyKeyboardInset.hideWidgetByKeyboard(context))
                BlocListener<UpdateInfoCubit, UpdateInfoState>(
                  listener: (context, state) {
                    if (state is UpdateResiDetailLoading) {
                      MyScreenLoader.onScreenLoader(context);
                    }
                    if (state is UpdateResiDetailError) {
                      Navigator.pop(context);
                      MySnackBar.showSnackBar(context, state.error.toString());
                    }
                    if (state is UpdateResiDetailLoaded) {
                      Navigator.pop(context);
                      MySnackBar.showSnackBar(context, state.residentialDetailsModal.responseMsg.toString());
                      var profileCubit = ProfileCubit.get(context);
                      profileCubit.getProfile();
                      Navigator.pop(context);
                    }
                  },
                  child: Column(
                    children: [
                      InfoBoxContinueWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var updateCubit = UpdateInfoCubit.get(context);

                            updateCubit.updateResidentialDetails(
                                resiStatus: widget.accommodationTypeController.text.trim(),
                                landmark: widget.nearLandmarkTypeController.text.trim(),
                                curAdd: widget.currentAddressTypeController.text.trim(),
                                curCity: widget.currentCityId,
                                curPinCode: widget.currentPinCodeTypeController.text.trim(),
                                curState: widget.currentStateId,
                                perAdd: isSameResident
                                    ? widget.currentAddressTypeController.text.trim()
                                    : widget.permanentAddressController.text.trim(),
                                perCity: isSameResident ? widget.currentCityId : widget.perCityId,
                                perPinCode: isSameResident
                                    ? widget.currentPinCodeTypeController.text.trim()
                                    : widget.permanentPinCodeTypeController.text.trim(),
                                perState: isSameResident ? widget.currentStateId : widget.perStateId);
                          }
                        },
                      ),
                    ],
                  ),
                )
            ])));
  }
}
