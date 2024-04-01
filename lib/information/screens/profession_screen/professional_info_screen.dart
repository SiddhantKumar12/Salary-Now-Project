import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salarynow/information/cubit/employment_cubit/employment_detail_cubit.dart';
import 'package:salarynow/information/screens/profession_screen/professional_submit.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import '../../../utils/snackbar.dart';
import '../../../form_helper/form_helper_cubit/salary_cubit.dart';

class ProfessionalInfoScreen extends StatelessWidget {
  final bool? noHitProfileApi;
  ProfessionalInfoScreen({
    Key? key,
    this.noHitProfileApi = false,
  }) : super(key: key);

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController salaryModeController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController salaryDateController = TextEditingController();
  final TextEditingController empTypeController = TextEditingController();

  String stateId = "0";
  String? cityId;
  String salaryModeId = "0";
  String empId = "0";
  bool? salaryChecked;

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
              companyNameController.text = data!.companyName!;
              designationController.text = data.designation!;
              companyEmailController.text = data.workingemail!;
              companyAddressController.text = data.officeAddress!;
              pinCodeController.text = data.officePincode!;
              cityController.text = data.officeCityName!;
              stateId = data.officeState!;
              cityId = data.officeCity!;
              stateController.text = data.officeStateName!;
              salaryController.text = data.salary!;
              educationController.text = data.education!;
              salaryModeController.text = data.salaryModeName!;
              salaryModeId = data.salaryMode!;
              empId = data.employmentType!;
              empTypeController.text = data.employmentTypeName!;
              salaryChecked = data.microStatus!;
              String formattedDate = data.salaryDate!;
              salaryDateController.text = formattedDate;
              double salary = salaryController.text.trim().isNotEmpty ? double.parse(salaryController.text.trim()) : 0;
              context.read<SalaryCubit>().checkApprovalStatus(salary);
              return ProfessionalInfoSubmit(
                salaryChecked: salaryChecked,
                empTypeController: empTypeController,
                empId: empId,
                nohitProfileApi: noHitProfileApi!,
                cityId: cityId!,
                stateId: stateId,
                salaryModeId: salaryModeId,
                salaryDateController: salaryDateController,
                companyNameController: companyNameController,
                designationController: designationController,
                companyEmailController: companyEmailController,
                companyAddressController: companyAddressController,
                pinCodeController: pinCodeController,
                cityController: cityController,
                stateController: stateController,
                salaryController: salaryController,
                salaryModeController: salaryModeController,
                educationController: educationController,
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
