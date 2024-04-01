import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/form_helper/network/modal/user_common_modal.dart';
import 'package:salarynow/information/cubit/residential_cubit/residential_detail_cubit.dart';
import 'package:salarynow/information/screens/residential_screen/residential_info_submit.dart';
import 'package:salarynow/widgets/error.dart';
import '../../../form_helper/network/modal/state_modal.dart';
import '../../../storage/local_storage.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/loader.dart';

class ResidentialInfoScreen extends StatefulWidget {
  const ResidentialInfoScreen({Key? key}) : super(key: key);

  @override
  State<ResidentialInfoScreen> createState() => _ResidentialInfoScreenState();
}

class _ResidentialInfoScreenState extends State<ResidentialInfoScreen> {
  final TextEditingController accommodationTypeController = TextEditingController();
  final TextEditingController nearLandmarkTypeController = TextEditingController();
  final TextEditingController currentAddressTypeController = TextEditingController();
  final TextEditingController currentStateController = TextEditingController();
  final TextEditingController currentCityTypeController = TextEditingController();
  final TextEditingController currentPinCodeTypeController = TextEditingController();
  final TextEditingController permanentAddressController = TextEditingController();
  final TextEditingController permanentCityController = TextEditingController();
  final TextEditingController permanentStateController = TextEditingController();
  final TextEditingController permanentPinCodeTypeController = TextEditingController();

  UserCommonModal? userCommonModal = MyStorage.getUserCommonData();
  StateModal? stateModal = MyStorage.getStateData();

  bool isSameResident = false;
  bool isPerPinCode = false;
  bool isPerState = false;
  bool isPerCity = false;
  String? currentCityId;
  String? currentStateId;
  String? perCityId;
  String? perStateId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              accommodationTypeController.text = state.residentialDetailsModal.responseData!.residencialStatus!;
              nearLandmarkTypeController.text = state.residentialDetailsModal.responseData!.curLandmark!;
              currentAddressTypeController.text = state.residentialDetailsModal.responseData!.curAddress1!;
              currentPinCodeTypeController.text = state.residentialDetailsModal.responseData!.curPincode!;
              currentStateController.text = state.residentialDetailsModal.responseData!.curStateName!;
              currentCityTypeController.text = state.residentialDetailsModal.responseData!.curCityName!;
              permanentAddressController.text = state.residentialDetailsModal.responseData!.permAddress!;
              permanentCityController.text = state.residentialDetailsModal.responseData!.permCityName!;
              permanentStateController.text = state.residentialDetailsModal.responseData!.permStateName!;
              permanentPinCodeTypeController.text = state.residentialDetailsModal.responseData!.permPincode!;
              currentCityId = state.residentialDetailsModal.responseData!.curCity!;
              currentStateId = state.residentialDetailsModal.responseData!.curState!;
              perCityId = state.residentialDetailsModal.responseData!.permCity!;
              perStateId = state.residentialDetailsModal.responseData!.permState!;
              return ResidentialIntoSubmit(
                accommodationTypeController: accommodationTypeController,
                nearLandmarkTypeController: nearLandmarkTypeController,
                currentAddressTypeController: currentAddressTypeController,
                currentCityTypeController: currentCityTypeController,
                currentPinCodeTypeController: currentPinCodeTypeController,
                currentStateController: currentStateController,
                permanentAddressController: permanentAddressController,
                permanentCityController: permanentCityController,
                permanentPinCodeTypeController: permanentPinCodeTypeController,
                permanentStateController: permanentStateController,
                currentCityId: currentCityId,
                currentStateId: currentStateId,
                perCityId: perCityId,
                perStateId: perStateId,
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
