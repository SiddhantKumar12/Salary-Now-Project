import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/information/cubit/personal_cubit/personal_info_cubit.dart';
import '../../../utils/color.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/text_widget.dart';
import 'info_detail_widget.dart';

class PersonalViewScreen extends StatefulWidget {
  const PersonalViewScreen({Key? key}) : super(key: key);

  @override
  State<PersonalViewScreen> createState() => _PersonalViewScreenState();
}

class _PersonalViewScreenState extends State<PersonalViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const InfoCustomAppBar(),
      body: BlocProvider(
        create: (context) => PersonalInfoCubit(),
        child: BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
          listener: (context, state) {
            if (state is PersonalInfoError) {
              MySnackBar.showSnackBar(context, state.error.toString());
            }
          },
          builder: (context, state) {
            if (state is PersonalInfoLoaded) {
              var data = state.personalDetailsModal.responseData;

              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                      child: const InfoTitleWidget(
                        title: MyWrittenText.personalInfoText,
                        subtitle: 'Please find the following Personal details of yours',
                      ),
                    ),
                    SizedBox(height: 15.h),
                    InfoDetailWidget(
                      title: MyWrittenText.panCardNoText,
                      subtitle: data!.panNo!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.fullNameText,
                      subtitle: data.fullname!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.fatherName,
                      subtitle: data.fatherName!.toUpperCase(),
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.alternateNoText,
                      subtitle: data.alterMobile!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.emailIDText,
                      subtitle: data.email!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.dOBText,
                      subtitle: data.dob!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.genderText,
                      subtitle: data.gender!,
                    ),
                    InfoDetailWidget(title: MyWrittenText.martialStatusText, subtitle: data.maritalStatus!),
                    data.relationStatus == true
                        ? Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                                color: MyColor.whiteColor,
                                child: MyText(
                                  text: "${MyWrittenText.contact} 1",
                                  fontSize: 20.h,
                                  color: MyColor.titleTextColor,
                                ),
                              ),
                              InfoDetailWidget(
                                title: MyWrittenText.relationshipText,
                                subtitle: data.emprelationship1!,
                              ),
                              InfoDetailWidget(
                                title: MyWrittenText.contactNumberText,
                                subtitle: data.relationMobile1!,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                color: MyColor.whiteColor,
                                child: MyText(
                                  text: "${MyWrittenText.contact} 2",
                                  fontSize: 20.h,
                                  color: MyColor.titleTextColor,
                                ),
                              ),
                              InfoDetailWidget(
                                title: MyWrittenText.relationshipText,
                                subtitle: data.emprelationship2!,
                              ),
                              InfoDetailWidget(
                                title: MyWrittenText.contactNumberText,
                                subtitle: data.relationMobile2!,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            } else if (state is PersonalInfoLoading) {
              return const MyLoader();
            } else {
              return MyErrorWidget(
                onPressed: () {
                  var cubit = PersonalInfoCubit.get(context);
                  cubit.getPersonalDetails();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
