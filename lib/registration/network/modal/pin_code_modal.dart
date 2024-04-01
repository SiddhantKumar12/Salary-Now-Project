class PinCodeModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  PinCodeModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  PinCodeModal.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? postOfficeName;
  String? pincode;
  String? city;
  String? district;
  String? state;
  String? cityId;
  String? stateId;

  ResponseData(
      {this.id, this.postOfficeName, this.pincode, this.city, this.district, this.state, this.cityId, this.stateId});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postOfficeName = json['PostOfficeName'];
    pincode = json['Pincode'];
    city = json['City'];
    district = json['District'];
    state = json['State'];
    cityId = json['city_id'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PostOfficeName'] = this.postOfficeName;
    data['Pincode'] = this.pincode;
    data['City'] = this.city;
    data['District'] = this.district;
    data['State'] = this.state;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    return data;
  }
}
