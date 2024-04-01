import 'package:flutter/material.dart';

class MyColor {
  static const Color purpleColor = Color(0xffA62B91);
  static const Color lightPurpleColor = Color(0xffF9CBF1);
  static const Color cyanColor = Color(0xff0E4C92);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff454a48);
  static const Color blueColor = Color(0xff5954D4);
  static const Color violetColor = Color(0xff8F7BFF);
  static const Color peachColor = Color(0xffECCFDA);
  static const Color titleTextColor = Color(0xff010101);
  static const Color subtitleTextColor = Color(0xff979797);
  static const Color limeColor = Color(0xffB7CAC6);
  static const Color lightBlueColor = Color(0xffCDDAFA);
  static const Color turcoiseColor = Color(0xff429FB8);
  static const Color lightTurcoiseColor = Color(0xffD4F4FC);
  static const Color greenColor = Color(0xff4DB629);
  static const Color redColor = Color(0xffff5733);
  static const Color highLightBlueColor = Color(0xffD4F4FC);
  static const Color amberColor = Colors.amber;
  static const Color containerBGColor = Color(0xffFBFBFB);
  static const Color newScaffoldBGColor = Color(0xffF6F5F0);
  static const Color dividerColor = Color(0xffF1F1F1);
  static const Color placeHolderColor = Color(0xff989898);
  static const Color transparentColor = Colors.transparent;
  static const Color textFieldBorderColor = Color(0xffC5C2C2);
  static const Color textFieldFillColor = Color(0xfff8f6f6);
  static const Color overdueColor = Color(0xffFFD6D9);
  static const Color overdueButtonColor = Color(0xffD12B36);
  static const Color partialPayBGColor = Color(0xffCDCBF7);
  static const Color partialPayColor = Color(0xff5954D4);
  static const Color paidColor = Color(0xff7D7D7D);
  static const Color paidBgColor = Color(0xffEDEDED);
  static const Color warningYellowColor = Color(0xfff0ad4e);
  static const Color primaryBlueColor = Color(0xff1A91CB);

  static const int _primaryValue = 0xff429FB8;

  static MaterialColor customPrimarySwatch = const MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xffE6F5F8),
      100: Color(0xffB3E4F0),
      200: Color(0xff80D3E8),
      300: Color(0xff4DB2D9),
      400: Color(0xff1A91CB),
      500: Color(_primaryValue), // Use the custom color value as the primary value
      600: Color(0xff0F7FAA),
      700: Color(0xff0A6982),
      800: Color(0xff054D5B),
      900: Color(0xff02333D),
    },
  );
}
