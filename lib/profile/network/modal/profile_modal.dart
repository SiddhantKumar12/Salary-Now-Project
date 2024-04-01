class ProfileModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  ProfileModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  ProfileModal.fromJson(Map<String, dynamic> json) {
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
  bool? company;
  bool? selfi;
  bool? bankfile;
  bool? addressproofback;
  bool? addressprooffront;
  bool? idproofback;
  bool? idprooffront;
  bool? pan;
  bool? salaryslip;
  bool? aggrement;
  bool? bankVerify;
  bool? addressProofVerify;
  bool? addressVerifyFront;
  bool? idproofverify;
  bool? idproofverifyfront;
  bool? pancardFileverify;
  bool? salaryVerifyFile;
  bool? aggrementVerify;
  bool? personal;
  bool? employeement;
  bool? address;
  bool? residential;
  bool? bank;
  bool? govtAadhar;

  ResponseData(
      {this.company,
      this.selfi,
      this.bankfile,
      this.addressproofback,
      this.addressprooffront,
      this.idproofback,
      this.idprooffront,
      this.pan,
      this.salaryslip,
      this.aggrement,
      this.bankVerify,
      this.addressProofVerify,
      this.addressVerifyFront,
      this.idproofverify,
      this.idproofverifyfront,
      this.pancardFileverify,
      this.salaryVerifyFile,
      this.aggrementVerify,
      this.personal,
      this.employeement,
      this.address,
      this.residential,
      this.bank,
      this.govtAadhar});

  ResponseData.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    selfi = json['selfi'];
    bankfile = json['bankfile'];
    addressproofback = json['addressproofback'];
    addressprooffront = json['addressprooffront'];
    idproofback = json['idproofback'];
    idprooffront = json['idprooffront'];
    pan = json['pan'];
    salaryslip = json['salaryslip'];
    aggrement = json['aggrement'];
    bankVerify = json['bank_verify'];
    addressProofVerify = json['address_proof_verify'];
    addressVerifyFront = json['address_verify_front'];
    idproofverify = json['idproofverify'];
    idproofverifyfront = json['idproofverifyfront'];
    pancardFileverify = json['pancard_fileverify'];
    salaryVerifyFile = json['salary_verify_file'];
    aggrementVerify = json['aggrement_verify'];
    personal = json['personal'];
    employeement = json['employeement'];
    address = json['address'];
    residential = json['residential'];
    bank = json['bank'];
    govtAadhar = json['govt_aadhar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['selfi'] = this.selfi;
    data['bankfile'] = this.bankfile;
    data['addressproofback'] = this.addressproofback;
    data['addressprooffront'] = this.addressprooffront;
    data['idproofback'] = this.idproofback;
    data['idprooffront'] = this.idprooffront;
    data['pan'] = this.pan;
    data['salaryslip'] = this.salaryslip;
    data['aggrement'] = this.aggrement;
    data['bank_verify'] = this.bankVerify;
    data['address_proof_verify'] = this.addressProofVerify;
    data['address_verify_front'] = this.addressVerifyFront;
    data['idproofverify'] = this.idproofverify;
    data['idproofverifyfront'] = this.idproofverifyfront;
    data['pancard_fileverify'] = this.pancardFileverify;
    data['salary_verify_file'] = this.salaryVerifyFile;
    data['aggrement_verify'] = this.aggrementVerify;
    data['personal'] = this.personal;
    data['employeement'] = this.employeement;
    data['address'] = this.address;
    data['residential'] = this.residential;
    data['bank'] = this.bank;
    data['govt_aadhar'] = this.govtAadhar;
    return data;
  }
}
