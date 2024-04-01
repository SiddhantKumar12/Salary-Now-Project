class LoginModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  LoginModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  LoginModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseData = json['response_data'] != null ? ResponseData.fromJson(json['response_data']) : null;
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['response_status'] = responseStatus;
    if (responseData != null) {
      data['response_data'] = responseData!.toJson();
    }
    data['response_msg'] = responseMsg;
    return data;
  }
}

class ResponseData {
  String? mobile;
  String? status;

  ResponseData({this.mobile, this.status});

  ResponseData.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['status'] = this.status;
    return data;
  }
}
