class EmpDetailModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  EmpDetailModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  EmpDetailModal.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  String? designation;
  String? salary;
  String? salaryMode;
  String? salaryModeName;
  String? officeAddress;
  String? officeCity;
  String? officeCityName;
  String? officeState;
  String? officeStateName;
  String? officePincode;
  String? salaryDate;
  String? education;
  String? workingemail;
  String? employmentType;
  String? employmentTypeName;
  String? nomonthwork;
  bool? microStatus;

  ResponseData(
      {this.usersId,
      this.token,
      this.companyName,
      this.designation,
      this.salary,
      this.salaryMode,
      this.salaryModeName,
      this.officeAddress,
      this.officeCity,
      this.officeCityName,
      this.officeState,
      this.officeStateName,
      this.officePincode,
      this.salaryDate,
      this.education,
      this.workingemail,
      this.employmentType,
      this.employmentTypeName,
      this.nomonthwork,
      this.microStatus});

  ResponseData.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    token = json['token'];
    companyName = json['company_name'];
    designation = json['designation'];
    salary = json['salary'];
    salaryMode = json['salary_mode'];
    salaryModeName = json['salary_mode_name'];
    officeAddress = json['office_address'];
    officeCity = json['office_city'];
    officeCityName = json['office_city_name'];
    officeState = json['office_state'];
    officeStateName = json['office_state_name'];
    officePincode = json['office_pincode'];
    salaryDate = json['salary_date'];
    education = json['education'];
    workingemail = json['workingemail'];
    employmentType = json['employment_type'];
    employmentTypeName = json['employment_type_name'];
    nomonthwork = json['nomonthwork'];
    microStatus = json['micro_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['token'] = this.token;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    data['salary'] = this.salary;
    data['salary_mode'] = this.salaryMode;
    data['salary_mode_name'] = this.salaryModeName;
    data['office_address'] = this.officeAddress;
    data['office_city'] = this.officeCity;
    data['office_city_name'] = this.officeCityName;
    data['office_state'] = this.officeState;
    data['office_state_name'] = this.officeStateName;
    data['office_pincode'] = this.officePincode;
    data['salary_date'] = this.salaryDate;
    data['education'] = this.education;
    data['workingemail'] = this.workingemail;
    data['employment_type'] = this.employmentType;
    data['employment_type_name'] = this.employmentTypeName;
    data['nomonthwork'] = this.nomonthwork;
    data['micro_status'] = this.microStatus;
    return data;
  }
}
