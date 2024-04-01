class UpdateMicroStatusModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  UpdateMicroStatusModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  UpdateMicroStatusModal.fromJson(Map<String, dynamic> json) {
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
  String? microStatus;
  String? userType;
  String? microRequired;

  ResponseData({this.microStatus, this.userType, this.microRequired});

  ResponseData.fromJson(Map<String, dynamic> json) {
    microStatus = json['micro_status'];
    userType = json['user_type'];
    microRequired = json['micro_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['micro_status'] = this.microStatus;
    data['user_type'] = this.userType;
    data['micro_required'] = this.microRequired;
    return data;
  }
}
