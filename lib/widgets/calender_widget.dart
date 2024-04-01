import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/form_helper/form_helper_cubit/form_helper_cubit.dart';
import '../registration/cubit/registration_cubit.dart';

class MyCalenderWidget {
  static showCalender(BuildContext context) {
    var date = DateTime(
      DateTime.now().year - 18,
      DateTime.now().month,
      DateTime.now().day,
    );
    showDatePicker(
            context: context,
            initialDate: date, //get today's date
            firstDate: DateTime(1969), //DateTime.now() - not to allow to choose before today.
            lastDate: date)
        .then((value) => {
              context.read<RegistrationCubit>().setDate(value!),
              log(value.toString()),
            });
  }

  static showSalaryCalender(BuildContext context) {
    var date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    var lastDate = DateTime(
      DateTime.now().year,
      DateTime.now().month + 2,
      DateTime.now().day,
    );
    showDatePicker(
            context: context,
            initialDate: date, //get today's date
            firstDate: DateTime(1969), //DateTime.now() - not to allow to choose before today.
            lastDate: lastDate)
        .then((value) => {
              context.read<FormHelperApiCubit>().setDate(value!),
            });
  }

  static showPersonalDOBCalender(BuildContext context) {
    var date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    showDatePicker(
            context: context,
            initialDate: date, //get today's date
            firstDate: DateTime(1969), //DateTime.now() - not to allow to choose before today.
            lastDate: date)
        .then((value) => {
              context.read<FormHelperApiCubit>().setDate(value!),
            });
  }
}
