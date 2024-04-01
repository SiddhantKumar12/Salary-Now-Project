class AadhaarCardVerifyModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  AadhaarCardVerifyModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  AadhaarCardVerifyModal.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? aadhaarNumber;
  String? dob;
  String? gender;
  String? zip;
  String? address;
  State? state;
  State? city;

  ResponseData(
      {this.fullName, this.aadhaarNumber, this.dob, this.gender, this.zip, this.address, this.state, this.city});

  ResponseData.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    aadhaarNumber = json['aadhaar_number'];
    dob = json['dob'];
    gender = json['gender'];
    zip = json['zip'];
    address = json['address'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new State.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['zip'] = this.zip;
    data['address'] = this.address;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class State {
  String? id;
  String? name;

  State({this.id, this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
