class PersonalDetailsModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  PersonalDetailsModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  PersonalDetailsModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseData = json['response_data'] != null ? new ResponseData.fromJson(json['response_data']) : null;
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class ResponseData {
  String? usersId;
  String? token;
  String? fullname;
  String? panNo;
  String? maritalStatus;
  String? fatherName;
  String? gender;
  String? alterMobile;
  String? email;
  String? emprelationship1;
  String? relationName1;
  String? relationMobile1;
  String? emprelationship2;
  String? relationName2;
  String? relationMobile2;
  String? dob;
  bool? isedit;
  bool? relationStatus;

  ResponseData(
      {this.usersId,
      this.token,
      this.fullname,
      this.panNo,
      this.maritalStatus,
      this.fatherName,
      this.gender,
      this.alterMobile,
      this.email,
      this.emprelationship1,
      this.relationName1,
      this.relationMobile1,
      this.emprelationship2,
      this.relationName2,
      this.relationMobile2,
      this.dob,
      this.isedit,
      this.relationStatus});

  ResponseData.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    token = json['token'];
    fullname = json['fullname'];
    panNo = json['pan_no'];
    maritalStatus = json['marital_status'];
    fatherName = json['father_name'];
    gender = json['gender'];
    alterMobile = json['alterMobile'];
    email = json['email'];
    emprelationship1 = json['emprelationship1'];
    relationName1 = json['relationName1'];
    relationMobile1 = json['relationMobile1'];
    emprelationship2 = json['emprelationship2'];
    relationName2 = json['relationName2'];
    relationMobile2 = json['relationMobile2'];
    dob = json['dob'];
    isedit = json['isedit'];
    relationStatus = json['relation_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['token'] = this.token;
    data['fullname'] = this.fullname;
    data['pan_no'] = this.panNo;
    data['marital_status'] = this.maritalStatus;
    data['father_name'] = this.fatherName;
    data['gender'] = this.gender;
    data['alterMobile'] = this.alterMobile;
    data['email'] = this.email;
    data['emprelationship1'] = this.emprelationship1;
    data['relationName1'] = this.relationName1;
    data['relationMobile1'] = this.relationMobile1;
    data['emprelationship2'] = this.emprelationship2;
    data['relationName2'] = this.relationName2;
    data['relationMobile2'] = this.relationMobile2;
    data['dob'] = this.dob;
    data['isedit'] = this.isedit;
    data['relation_status'] = this.relationStatus;
    return data;
  }
}
