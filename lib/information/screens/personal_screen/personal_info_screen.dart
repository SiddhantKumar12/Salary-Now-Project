import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/dashboard/cubit/get_selfie_cubit/get_selfie_cubit.dart';
import 'package:salarynow/information/cubit/personal_cubit/personal_info_cubit.dart';
import 'package:salarynow/information/screens/personal_screen/personal_info_submit.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/error.dart';
import '../../../widgets/loader.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController alternateNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController empRelationShip1Controller = TextEditingController();
  final TextEditingController relationName1Controller = TextEditingController();
  final TextEditingController relationMobile1Controller = TextEditingController();
  final TextEditingController empRelationship2Controller = TextEditingController();
  final TextEditingController relationName2Controller = TextEditingController();
  final TextEditingController relationMobile2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    var getDocCubit = GetSelfieCubit.get(context);
    getDocCubit.getSelfie(doctype: 'selfie');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              panCardController.text = data!.panNo!;
              fullNameController.text = data.fullname!;
              genderController.text = data.gender!;
              maritalStatusController.text = data.maritalStatus!;
              fatherNameController.text = data.fatherName!;
              alternateNoController.text = data.alterMobile!;
              emailController.text = data.email!;
              relationMobile1Controller.text = data.relationMobile1!;
              empRelationShip1Controller.text = data.emprelationship1!;
              relationName1Controller.text = data.relationName1!;
              relationMobile2Controller.text = data.relationMobile2!;
              empRelationship2Controller.text = data.emprelationship2!;
              relationName2Controller.text = data.relationName2!;
              dobController.text = data.dob!;
              return PersonalInfoSubmit(
                  relationStatus: data.relationStatus!,
                  panCardController: panCardController,
                  fullNameController: fullNameController,
                  genderController: genderController,
                  maritalStatusController: maritalStatusController,
                  fatherNameController: fatherNameController,
                  alternateNoController: alternateNoController,
                  emailController: emailController,
                  dobController: dobController,
                  empRelationShip1Controller: empRelationShip1Controller,
                  relationName1Controller: relationName1Controller,
                  relationMobile1Controller: relationMobile1Controller,
                  empRelationship2Controller: empRelationship2Controller,
                  relationName2Controller: relationName2Controller,
                  relationMobile2Controller: relationMobile2Controller);
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
