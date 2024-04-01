class CheckMicroUserModal {
  int? responseCode;
  int? responseStatus;
  bool? responseData;
  String? responseMsg;

  CheckMicroUserModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  CheckMicroUserModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseData = json['response_data'];
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    data['response_data'] = this.responseData;
    data['response_msg'] = this.responseMsg;
    return data;
  }
}
