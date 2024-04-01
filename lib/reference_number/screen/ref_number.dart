import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/permission_handler/network/call_log_modal.dart';
import 'package:salarynow/reference_number/cubit/contact_ref/contact_ref_cubit.dart';
import 'package:salarynow/reference_number/cubit/user_ref_number/user_reference_number_cubit.dart';
import 'package:salarynow/reference_number/network/contact_ref_status_modal.dart';
import 'package:salarynow/reference_number/screen/ref_number_dialog_box.dart';
import 'package:salarynow/utils/bottom_sheet.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_textfield_widget.dart';
import 'package:salarynow/widgets/onTap_textfield_icon_widget.dart';
import '../../utils/snackbar.dart';
import '../../widgets/loader.dart';
import '../cubit/contact_ref_status/contact_ref_status_cubit.dart';
import '../../widgets/text_widget.dart';

class RefNumber extends StatefulWidget {
  final ContactRefStatusModal contactRefStatusModal;
  const RefNumber({super.key, required this.contactRefStatusModal});

  @override
  State<RefNumber> createState() => _RefNumberState();
}

class _RefNumberState extends State<RefNumber> {
  List<TextEditingController> relationTypeController = [];
  List<TextEditingController> relationNameController = [];
  List<TextEditingController> relationNumberController = [];

  List<MyCallLogModal> callLogData = [];
  int showStatus = 0;

  @override
  void initState() {
    super.initState();

    var cubit = UserReferenceNumberCubit.get(context);
    cubit.fetchRefNumber();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<UserReferenceNumberCubit, UserReferenceNumberState>(
          listener: (context, state) {
            if (state is UserReferenceNumberLoading) {
              MyScreenLoader.onScreenLoader(context);
            }
            if (state is UserReferenceNumberLoaded) {
              callLogData = state.callLog;
              getRefNumberDialog(context: context, contactRefStatusModal: widget.contactRefStatusModal);
            }
            if (state is UserReferenceNumberError) {
              Navigator.pop(context);
              Navigator.pop(context);
              showError(context: context, error: state.errorMessage);
            }
          },
          child: Container(
            color: MyColor.whiteColor,
            child: const MyLoader(),
          ),
        ),
      ),
    );
  }

  getRefNumberDialog({required BuildContext context, required ContactRefStatusModal contactRefStatusModal}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: StatefulBuilder(builder: (context, setState) {
            List<AccordionSection> newList = [];
            for (int i = 1; i <= contactRefStatusModal.responseCount!; i++) {
              relationTypeController.add(TextEditingController());
              relationNameController.add(TextEditingController());
              relationNumberController.add(TextEditingController());
              newList.add(AccordionSection(
                  isOpen: i == 1 ? true : false,
                  header: MyText(text: 'Reference $i'),
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            MyBottomSheet.relationModalBottomSheet(
                                relationList: RelationModal.relationList,
                                fieldSelected: relationTypeController[i - 1].text.trim(),
                                context: context,
                                onSelected: (value) {
                                  relationTypeController[i - 1].text = value;
                                });
                          },
                          child: InfoTextFieldWidget(
                            enabled: false,
                            title: MyWrittenText.relationshipText,
                            textEditingController: relationTypeController[i - 1],
                            hintText: MyWrittenText.enterRelationshipText,
                            textInputType: TextInputType.name,
                            suffixIcon: OnTapTextFieldSuffixIconWidget(
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            MyRefDialogBox.showContact(
                                callLogData: callLogData,
                                context: context,
                                number: (data) {
                                  relationNumberController[i - 1].text = data;
                                },
                                name: (data) {
                                  relationNameController[i - 1].text = data;
                                });
                          },
                          child: Column(
                            children: [
                              InfoTextFieldWidget(
                                enabled: false,
                                title: MyWrittenText.contactNameText,
                                textEditingController: relationNameController[i - 1],
                                hintText: MyWrittenText.enterContactNumberText,
                              ),
                              SizedBox(height: 20.h),
                              InfoTextFieldWidget(
                                enabled: false,
                                title: MyWrittenText.contactNumberText,
                                textEditingController: relationNumberController[i - 1],
                                hintText: MyWrittenText.enterContactNumberText,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                suffixIcon:
                                    OnTapTextFieldSuffixIconWidget(onPressed: () {}, icon: const Icon(Icons.phone)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )));
            }
            return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                insetPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 40.h),
                        MyText(
                          text: 'Select ${contactRefStatusModal.responseCount} Reference Numbers',
                          fontSize: 22.sp,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5.h),
                        Accordion(
                          rightIcon: const SizedBox(),
                          maxOpenSections: 1,
                          headerBackgroundColorOpened: MyColor.turcoiseColor.withOpacity(0.5),
                          headerBackgroundColor: MyColor.subtitleTextColor.withOpacity(0.2),
                          scaleWhenAnimating: true,
                          openAndCloseAnimation: true,
                          disableScrolling: true,
                          headerPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                          children: newList,
                        ),
                        Transform.translate(
                          offset: Offset(0, -20.h),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                const Divider(),
                                BlocListener<ContactRefCubit, ContactRefState>(
                                  listener: (context, state) {
                                    if (state is ContactRefLoading) {
                                      MyScreenLoader.onScreenLoader(context);
                                    }
                                    if (state is ContactRefLoaded) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      var cubit = ContactRefStatusCubit.get(context);
                                      cubit.getContactRef();
                                      MySnackBar.showSnackBar(context, 'Click Proceed to Apply Loan');
                                    }
                                    if (state is ContactRefError) {
                                      Navigator.pop(context);
                                      showError(context: context, error: state.error);
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      var cubit = ContactRefCubit.get(context);
                                      Map<String, dynamic> newData = {};
                                      for (int i = 1; i <= contactRefStatusModal.responseCount!; i++) {
                                        newData['relationship$i'] = relationTypeController[i - 1].text.trim();
                                        newData['relationName$i'] = relationNameController[i - 1].text.trim();
                                        newData['relationMobile$i'] = relationNumberController[i - 1].text.trim();
                                      }
                                      newData['total_count'] = contactRefStatusModal.responseCount;
                                      cubit.postContactRef(data: newData);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                      width: double.maxFinite,
                                      child: MyText(
                                        text: 'Submit',
                                        textAlign: TextAlign.center,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 3.h),
                                    width: double.maxFinite,
                                    child: MyText(
                                      text: MyWrittenText.cancelText,
                                      color: MyColor.redColor,
                                      textAlign: TextAlign.center,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
        );
      },
    );
  }

  void showError({
    required BuildContext context,
    required String error,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: MyText(text: error),
          actions: [
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const MyText(text: 'Go Back'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
