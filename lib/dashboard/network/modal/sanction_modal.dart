class SanctionModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  SanctionModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  SanctionModal.fromJson(Map<String, dynamic> json) {
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
  String? sactionUrl;
  String? loanNo;

  ResponseData({this.sactionUrl, this.loanNo});

  ResponseData.fromJson(Map<String, dynamic> json) {
    sactionUrl = json['sactionUrl'];
    loanNo = json['loanNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sactionUrl'] = this.sactionUrl;
    data['loanNo'] = this.loanNo;
    return data;
  }
}
