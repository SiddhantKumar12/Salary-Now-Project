import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salarynow/utils/written_text.dart';

import 'color.dart';

class MyAppThemeData {
  static final themeData = ThemeData(
      fontFamily: MyWrittenText.poppins,
      primaryColor: MyColor.turcoiseColor,
      errorColor: MyColor.turcoiseColor,
      primarySwatch: MyColor.customPrimarySwatch,
      scaffoldBackgroundColor: MyColor.whiteColor,
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: MyColor.turcoiseColor,
      )));
}
