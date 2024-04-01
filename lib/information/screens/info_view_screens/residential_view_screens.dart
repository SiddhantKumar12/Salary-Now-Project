import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/information/cubit/residential_cubit/residential_detail_cubit.dart';
import '../../../utils/color.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/text_widget.dart';
import 'info_detail_widget.dart';

class ResidentialViewScreen extends StatelessWidget {
  const ResidentialViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const InfoCustomAppBar(),
      body: BlocProvider(
        create: (context) => ResiDetailCubit(),
        child: BlocConsumer<ResiDetailCubit, ResiDetailState>(
          listener: (context, state) {
            if (state is ResidentialDetailError) {
              MySnackBar.showSnackBar(context, state.error.toString());
            }
          },
          builder: (context, state) {
            if (state is ResidentialDetailLoaded) {
              var data = state.residentialDetailsModal.responseData;

              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                      child: const InfoTitleWidget(
                        title: MyWrittenText.residentialDetailText,
                        subtitle: 'Please find the following Residential details of yours',
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoDetailWidget(
                          title: MyWrittenText.accommodationType,
                          subtitle: data!.residencialStatus!.toUpperCase(),
                          noDivider: true,
                        ),
                        Divider(thickness: 2.h, height: 40.h),
                        Container(
                          width: double.maxFinite,
                          color: MyColor.whiteColor,
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                          child: MyText(
                            text: MyWrittenText.currentAdd,
                            fontSize: 20.sp,
                            color: MyColor.titleTextColor,
                          ),
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.nearLandmark,
                          subtitle: data.curLandmark!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.address,
                          subtitle: data.curAddress1!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.pinCodeeText,
                          subtitle: data.curPincode!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.stateText,
                          subtitle: data.curStateName!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.cityText,
                          subtitle: data.curCityName!,
                          noDivider: true,
                        ),
                        Divider(thickness: 2.h, height: 40.h),
                        Container(
                          width: double.maxFinite,
                          color: MyColor.whiteColor,
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                          child: MyText(
                            text: MyWrittenText.permanentAdd,
                            fontSize: 20.sp,
                            color: MyColor.titleTextColor,
                          ),
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.address,
                          subtitle: data.permAddress!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.pinCodeeText,
                          subtitle: data.permPincode!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.stateText,
                          subtitle: data.permStateName!,
                        ),
                        InfoDetailWidget(
                          title: MyWrittenText.cityText,
                          subtitle: data.permCityName!,
                          noDivider: true,
                        ),
                        SizedBox(height: 15.h),
                      ],
                    )
                  ],
                ),
              );
            } else if (state is ResidentialDetailLoading) {
              return const MyLoader();
            } else {
              return MyErrorWidget(
                onPressed: () {
                  var cubit = ResiDetailCubit.get(context);
                  cubit.getResidentialDetails();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
