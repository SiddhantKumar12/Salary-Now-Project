import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/widgets/loader.dart';

import '../../reference_number/cubit/contact_ref_status/contact_ref_status_cubit.dart';
import '../../reference_number/screen/ref_number.dart';
import '../network/modal/loan_calculator_modal.dart';
import 'loan_sumbit_screen.dart';

class CheckRefNumber extends StatefulWidget {
  final String productId;
  final String maxAmount;
  final String value;
  final LoanCalculatorModal loanCalculatorModal;
  const CheckRefNumber(
      {Key? key,
      required this.productId,
      required this.maxAmount,
      required this.value,
      required this.loanCalculatorModal})
      : super(key: key);

  @override
  State<CheckRefNumber> createState() => _CheckRefNumberState();
}

class _CheckRefNumberState extends State<CheckRefNumber> {
  @override
  void initState() {
    super.initState();
    var cubit = ContactRefStatusCubit.get(context);
    cubit.getContactRef();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<ContactRefStatusCubit, ContactRefStatusState>(
          listener: (context, state) {
            if (state is ContactRefStatusLoaded) {
              if (state.modal.responseDialogRefrence! == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RefNumber(
                            contactRefStatusModal: state.modal,
                          )),
                );
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoanSubmitScreen(
                              value: widget.value,
                              loanCalculatorModal: widget.loanCalculatorModal,
                              maxAmount: widget.maxAmount,
                              productId: widget.productId,
                            )));
              }
            }
          },
          child: MyLoader(),
        ),
      ),
    );
  }
}
