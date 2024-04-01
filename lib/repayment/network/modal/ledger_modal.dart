class LedgerModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  LedgerModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  LedgerModal.fromJson(Map<String, dynamic> json) {
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
  String? url;
  bool? misStatus;
  String? misButton;

  ResponseData({this.url, this.misStatus, this.misButton});

  ResponseData.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    misStatus = json['mis_status'];
    misButton = json['mis_button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['mis_status'] = this.misStatus;
    data['mis_button'] = this.misButton;
    return data;
  }
}
