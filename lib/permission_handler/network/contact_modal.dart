import 'dart:convert';

class MyContactModal {
  String? displayName;
  String? givenName;
  String? middleName;
  String? prefix;
  String? suffix;
  String? familyName;
  String? company;
  String? jobTitle;
  List<String>? emails;
  String? phones;
  List<String>? postalAddresses;
  String? avatar;
  DateTime? birthday;
  String? androidAccountType;
  String? androidAccountTypeRaw;
  String? androidAccountName;

  MyContactModal({
    this.displayName,
    this.givenName,
    this.middleName,
    this.prefix,
    this.suffix,
    this.familyName,
    this.company,
    this.jobTitle,
    this.emails,
    this.phones,
    this.postalAddresses,
    this.avatar,
    this.birthday,
    this.androidAccountType,
    this.androidAccountTypeRaw,
    this.androidAccountName,
  });

  factory MyContactModal.fromJson(Map<String, dynamic> json) {
    return MyContactModal(
      displayName: json['displayName'],
      givenName: json['givenName'],
      middleName: json['middleName'],
      prefix: json['prefix'],
      suffix: json['suffix'],
      familyName: json['familyName'],
      company: json['company'],
      jobTitle: json['jobTitle'],
      emails: List<String>.from(json['emails']),
      phones: json['phones'],
      postalAddresses: List<String>.from(json['postalAddresses']),
      avatar: json['avatar'],
      birthday: DateTime.parse(json['birthday']),
      androidAccountType: json['androidAccountType'],
      androidAccountTypeRaw: json['androidAccountTypeRaw'],
      androidAccountName: json['androidAccountName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'givenName': givenName,
      'middleName': middleName,
      'prefix': prefix,
      'suffix': suffix,
      'familyName': familyName,
      'company': company,
      'jobTitle': jobTitle,
      'emails': emails,
      'phones': phones,
      'postalAddresses': postalAddresses,
      'avatar': avatar,
      'birthday': birthday?.toIso8601String() ?? '',
      'androidAccountType': androidAccountType,
      'androidAccountTypeRaw': androidAccountTypeRaw,
      'androidAccountName': androidAccountName,
    };
  }
}
