import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/information/cubit/banking_cubit/banking_detail_cubit.dart';
import 'package:salarynow/information/screens/banking_screen/banking_info_submit.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';

class BankingInfoScreen extends StatelessWidget {
  BankingInfoScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController iFSCController = TextEditingController();
  final TextEditingController accNumberController = TextEditingController();
  final TextEditingController reEnterAccNumberController = TextEditingController();
  final TextEditingController branchAddController = TextEditingController();

  String bankID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const InfoCustomAppBar(),
        body: BlocProvider(
          create: (context) => BankingDetailCubit(),
          child: BlocConsumer<BankingDetailCubit, BankingDetailState>(
            listener: (context, state) {
              if (state is BankingDetailError) {
                MySnackBar.showSnackBar(context, state.error.toString());
              }
              if (state is BankingDetailError) {
                MySnackBar.showSnackBar(context, state.error.toString());
              }
            },
            builder: (context, state) {
              if (state is BankingDetailLoaded) {
                bankID = state.bankingDetailsModal.responseData!.bankid!;
                bankNameController.text = state.bankingDetailsModal.responseData!.bankName!;
                iFSCController.text = state.bankingDetailsModal.responseData!.ifsc!;
                accNumberController.text = state.bankingDetailsModal.responseData!.accountNo!;
                reEnterAccNumberController.text = state.bankingDetailsModal.responseData!.accountNo!;
                branchAddController.text = state.bankingDetailsModal.responseData!.branchName!;
                return BankingInfoSubmit(
                    bankID: bankID,
                    bankNameController: bankNameController,
                    iFSCController: iFSCController,
                    accNumberController: accNumberController,
                    reEnterAccNumberController: reEnterAccNumberController,
                    branchAddController: branchAddController);
              } else if (state is BankingDetailLoading) {
                return const MyLoader();
              } else {
                return MyErrorWidget(
                  onPressed: () {
                    var cubit = BankingDetailCubit.get(context);
                    cubit.getBankDetails();
                  },
                );
              }
            },
          ),
        ));
  }
}
