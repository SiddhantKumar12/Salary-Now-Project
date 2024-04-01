import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../cubit/employment_cubit/employment_detail_cubit.dart';
import 'info_detail_widget.dart';

class ProfessionalViewScreen extends StatelessWidget {
  const ProfessionalViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const InfoCustomAppBar(),
      body: BlocProvider(
        create: (context) => EmploymentDetailCubit(),
        child: BlocConsumer<EmploymentDetailCubit, EmploymentDetailState>(
          listener: (context, state) {
            if (state is EmploymentDetailError) {
              MySnackBar.showSnackBar(context, state.error.toString());
            }
          },
          builder: (context, state) {
            if (state is EmploymentDetailLoaded) {
              var data = state.empDetailModal.responseData;

              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                      child: const InfoTitleWidget(
                        title: MyWrittenText.professionalInfoText,
                        subtitle: 'Please find the following Professional details of yours',
                      ),
                    ),
                    SizedBox(height: 15.h),
                    InfoDetailWidget(
                      title: MyWrittenText.companyNameText,
                      subtitle: data!.companyName!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.designationText,
                      subtitle: data.designation!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.companyEmailIDText,
                      subtitle: data.workingemail!,
                    ),
                    // InfoDetailWidget(
                    //   title: MyWrittenText.workingMonthText,
                    //   subtitle: data.nomonthwork!,
                    // ),
                    InfoDetailWidget(
                      title: MyWrittenText.companyAddressText,
                      subtitle: data.officeAddress!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.pinCodeeText,
                      subtitle: data.officePincode!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.stateText,
                      subtitle: data.officeStateName!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.cityText,
                      subtitle: data.officeCityName!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.salaryText,
                      subtitle: data.salary!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.educationText,
                      subtitle: data.education!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.modeOfSalaryText,
                      subtitle: data.salaryModeName!,
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.salaryDateText,
                      subtitle: data.salaryDate!.substring(0, 10),
                    ),
                    InfoDetailWidget(
                      title: MyWrittenText.employmentTypeText,
                      subtitle: data.employmentTypeName!,
                    ),
                  ],
                ),
              );
            } else if (state is EmploymentDetailLoading) {
              return const MyLoader();
            } else {
              return MyErrorWidget(
                onPressed: () {
                  var cubit = EmploymentDetailCubit.get(context);
                  cubit.getEmpDetails();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
