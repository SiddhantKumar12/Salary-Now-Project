class MicroUserDisclaimerModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  MicroUserDisclaimerModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  MicroUserDisclaimerModal.fromJson(Map<String, dynamic> json) {
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
  bool? isdialogshow;
  bool? microStatus;

  ResponseData({this.isdialogshow, this.microStatus});

  ResponseData.fromJson(Map<String, dynamic> json) {
    isdialogshow = json['isdialogshow'];
    microStatus = json['micro_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isdialogshow'] = this.isdialogshow;
    data['micro_status'] = this.microStatus;
    return data;
  }
}
