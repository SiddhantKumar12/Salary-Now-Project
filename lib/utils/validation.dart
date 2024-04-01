import 'package:email_validator/email_validator.dart';
import 'package:salarynow/utils/written_text.dart';

class InputValidation {
  static final RegExp notNameRegExp = RegExp('[a-zA-Z]');
  static final RegExp nameRegExp = RegExp('[0-9]');
  static final RegExp noSpecialChar = RegExp("!^[`~!@#%^&*()-_=]+\$");

  static String? validatePanCard(String value) {
    String pattern = r'^[A-Z]{3}[P]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please Enter Pancard Number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Pancard Number';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Enter Your Name';
    } else if (!notNameRegExp.hasMatch(value)) {
      return 'Enter a Valid Name';
    } else if (nameRegExp.hasMatch(value)) {
      return 'Enter a Valid Name';
    } else if (noSpecialChar.hasMatch(value)) {
      return 'Enter a Valid Name';
    }
    return null;
  }

  static String? validateNumber(String number) {
    final regex = RegExp(r'^\d+$');

    if (number.isEmpty) {
      return 'Enter Your Number';
    } else if (number.startsWith("0") ||
        number.startsWith("1") ||
        number.startsWith("2") ||
        number.startsWith("3") ||
        number.startsWith("3") ||
        number.startsWith("5")) {
      return 'Enter Your Number';
    } else if (number.length < 10) {
      return 'Enter Your Number';
    } else if (!regex.hasMatch(number)) {
      return 'Enter a Valid Number';
    } else {
      int firstCharacter = int.parse(number);

      if (firstCharacter <= 5) {
        return 'Enter Valid Number';
      } else {
        return null;
      }
    }
  }

  static String? loginNumber(String number) {
    final regex = RegExp(r'^\d+$');

    if (number.isEmpty) {
      return MyWrittenText.enterMobileNoText;
    } else if (number.startsWith("0") ||
        number.startsWith("1") ||
        number.startsWith("2") ||
        number.startsWith("3") ||
        number.startsWith("3") ||
        number.startsWith("5")) {
      return 'Please Enter Correct Mobile No.';
    } else if (number.length < 10) {
      return MyWrittenText.enterMobileNoText;
    } else if (!regex.hasMatch(number)) {
      return 'Please Enter Correct Mobile No.';
    } else {
      int firstCharacter = int.parse(number);

      if (firstCharacter <= 5) {
        return 'Please Enter Correct Mobile No.';
      } else {
        return null;
      }
    }
  }

  static String? addressValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter address detail';
    } else if (value.startsWith("0")) {
      return 'Please enter correct address';
    } else if (value.length <= 5) {
      return 'Please enter correct address';
    }
    return null;
  }

  static String? salaryChecked(String value) {
    if (value.isEmpty) {
      return 'Please enter your Income';
    } else if (value.startsWith("0")) {
      return 'Please enter correct Income';
    }
    return null;
  }

  static String? emailValidation(String value) {
    if (!EmailValidator.validate(value)) {
      return "Enter Correct Email";
    }
    return null;
  }

  static String? notEmpty(String value) {
    if (value.isEmpty) {
      return "Please Fill This Field";
    }
    return null;
  }

  static String? aadhaarCard(String value) {
    if (value.isEmpty) {
      return "Please Fill This Field";
    } else if (value.length < 12) {
      'Enter Your Aadhaar Correctly';
    }
    return null;
  }
}
