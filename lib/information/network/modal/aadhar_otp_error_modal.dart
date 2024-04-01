class AadhaarOtpErrorModal {
  int? responseCode;
  int? responseStatus;
  bool? responseApi;
  String? responseMsg;

  AadhaarOtpErrorModal({this.responseCode, this.responseStatus, this.responseApi, this.responseMsg});

  AadhaarOtpErrorModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseApi = json['response_api'];
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    data['response_api'] = this.responseApi;
    data['response_msg'] = this.responseMsg;
    return data;
  }
}
