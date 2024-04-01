import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/get_not_interested_cubit/not_interested_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/divider_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_textfield_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../../utils/keyboard_bottom_inset.dart';
import '../../cubit/dashboard_cubit/dashboard_cubit.dart';
import '../../cubit/post_not_interested/post_not_intrested_cubit.dart';
import '../../network/modal/dashboard_modal.dart';

class NotInterestedScreen extends StatefulWidget {
  final DashBoardModal dashBoardModal;

  const NotInterestedScreen({Key? key, required this.dashBoardModal}) : super(key: key);

  @override
  State<NotInterestedScreen> createState() => _NotInterestedScreenState();
}

class _NotInterestedScreenState extends State<NotInterestedScreen> {
  LocalUserModal? localUserModal = MyStorage.getUserData();
  final _formKey = GlobalKey<FormState>();

  bool isExpanded = true;
  bool others = false;
  final TextEditingController othersController = TextEditingController();

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void toggleOthers() {
    setState(() {
      others = !others;
    });
  }

  String selectedId = "";
  String selectedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: 'Not Interested'),
      body: BlocProvider(
        create: (context) => NotInterestedCubit(),
        child: BlocBuilder<NotInterestedCubit, NotInterestedState>(
          builder: (context, state) {
            if (state is NotInterestedLoaded) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoTitleWidget(
                                title: "Dear ${localUserModal!.responseData!.name!}",
                                subtitle: '',
                              ),
                              MyText(
                                text: 'You have chose not to accept the loan :( We would like to know why',
                                fontSize: 18.sp,
                              ),
                              ListTile(
                                onTap: toggleExpansion,
                                contentPadding: EdgeInsets.zero,
                                title: MyText(
                                  text: 'Select Option',
                                  fontSize: 20.sp,
                                ),
                                trailing: SizedBox(
                                  width: 85.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      selectedId.isEmpty
                                          ? const SizedBox()
                                          : Container(
                                              height: 30.h,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: MyColor.turcoiseColor,
                                                  )),
                                              child: Center(
                                                  child: MyText(
                                                text: selectedId,
                                                color: MyColor.turcoiseColor,
                                              )),
                                            ),
                                      IconButton(
                                          onPressed: toggleExpansion,
                                          icon: Icon(
                                            isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: isExpanded ? 630.h : 0.0,
                                  child: ListView.separated(
                                      primary: false,
                                      separatorBuilder: (BuildContext context, int index) => const MyDivider(),
                                      shrinkWrap: true,
                                      itemCount: state.modal.responseData!.length,
                                      itemBuilder: (context, index) {
                                        int selectedValue = 0;
                                        var data = state.modal.responseData;
                                        if (selectedId == data![index].id) {
                                          selectedValue = int.parse(data[index].id!);
                                        }
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 5.h),
                                          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              selectedId = data[index].id!;
                                              selectedText = data[index].message!;
                                              setState(() {});
                                              toggleExpansion();
                                            },
                                            child: Row(children: [
                                              Expanded(
                                                flex: 1,
                                                child: MyText(
                                                  text: data[index].id!,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 9,
                                                child: MyText(
                                                  color: selectedValue == int.parse(data[index].id!)
                                                      ? MyColor.turcoiseColor
                                                      : MyColor.blackColor,
                                                  text: data[index].message ?? '',
                                                ),
                                              )
                                            ]),
                                          ),
                                        );
                                      })),
                              SizedBox(height: 10.h),
                              selectedId.isNotEmpty
                                  ? int.parse(selectedId) <= 9
                                      ? MyText(
                                          text: selectedText,
                                          color: MyColor.turcoiseColor,
                                        )
                                      : const SizedBox()
                                  : const SizedBox(),
                              selectedId == "10"
                                  ? InfoTextFieldWidget(
                                      title: 'Others',
                                      hintText: 'Please enter your reason',
                                      textEditingController: othersController,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter reason';
                                        }
                                        return null;
                                      },
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                      BlocListener<PostNotInterestedCubit, PostNotIntrestedState>(
                        listener: (context, state) {
                          if (state is PostNotIntrestedLoading) {
                            MyScreenLoader.onScreenLoader(context);
                          }
                          if (state is PostNotIntrestedLoaded) {
                            Navigator.pop(context);
                            var dashboardCubit = DashboardCubit.get(context);
                            dashboardCubit.getDashBoardData();
                            Navigator.pop(context);

                            MySnackBar.showSnackBar(context, state.modal.responseMsg!);
                          }
                          if (state is PostNotIntrestedError) {
                            Navigator.pop(context);
                            MySnackBar.showSnackBar(context, state.error);
                          }
                        },
                        child: Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: MyButton(
                                text: "Submit",
                                onPressed: () {
                                  var cubit = PostNotInterestedCubit.get(context);
                                  if (selectedText.isNotEmpty) {
                                    if (selectedId == "10") {
                                      if (_formKey.currentState!.validate()) {
                                        MyKeyboardInset.dismissKeyboard(context);
                                        cubit.postReason(
                                          remarks: othersController.text.trim(),
                                          loanId: widget.dashBoardModal.responseData!.loanDetails!.applicationNo!,
                                          reason: selectedText,
                                        );
                                      } else {
                                        MySnackBar.showSnackBar(context, 'Please Fill Your Reason');
                                      }
                                    } else {
                                      cubit.postReason(
                                        remarks: othersController.text.trim(),
                                        loanId: widget.dashBoardModal.responseData!.loanDetails!.applicationNo!,
                                        reason: selectedText,
                                      );
                                    }
                                  } else {
                                    MySnackBar.showSnackBar(context, 'Please Select Your Reason');
                                  }
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is NotInterestedLoading) {
              return const MyLoader();
            } else {
              return MyErrorWidget(onPressed: () {});
            }
          },
        ),
      ),
    );
  }
}
