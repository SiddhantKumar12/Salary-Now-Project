class ResidentialDetailsModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  ResidentialDetailsModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  ResidentialDetailsModal.fromJson(Map<String, dynamic> json) {
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
  String? residencialStatus;
  String? curLandmark;
  String? curAddress1;
  String? curCity;
  String? curCityName;
  String? curState;
  String? curStateName;
  String? curPincode;
  String? permAddress;
  String? permPincode;
  String? permCity;
  String? permCityName;
  String? permState;
  String? permStateName;

  ResponseData(
      {this.usersId,
      this.token,
      this.residencialStatus,
      this.curLandmark,
      this.curAddress1,
      this.curCity,
      this.curCityName,
      this.curState,
      this.curStateName,
      this.curPincode,
      this.permAddress,
      this.permPincode,
      this.permCity,
      this.permCityName,
      this.permState,
      this.permStateName});

  ResponseData.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    token = json['token'];
    residencialStatus = json['residencial_status'];
    curLandmark = json['cur_landmark'];
    curAddress1 = json['cur_address1'];
    curCity = json['cur_city'];
    curCityName = json['cur_city_name'];
    curState = json['cur_state'];
    curStateName = json['cur_state_name'];
    curPincode = json['cur_pincode'];
    permAddress = json['perm_address'];
    permPincode = json['perm_pincode'];
    permCity = json['perm_city'];
    permCityName = json['perm_city_name'];
    permState = json['perm_state'];
    permStateName = json['perm_state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['token'] = this.token;
    data['residencial_status'] = this.residencialStatus;
    data['cur_landmark'] = this.curLandmark;
    data['cur_address1'] = this.curAddress1;
    data['cur_city'] = this.curCity;
    data['cur_city_name'] = this.curCityName;
    data['cur_state'] = this.curState;
    data['cur_state_name'] = this.curStateName;
    data['cur_pincode'] = this.curPincode;
    data['perm_address'] = this.permAddress;
    data['perm_pincode'] = this.permPincode;
    data['perm_city'] = this.permCity;
    data['perm_city_name'] = this.permCityName;
    data['perm_state'] = this.permState;
    data['perm_state_name'] = this.permStateName;
    return data;
  }
}
