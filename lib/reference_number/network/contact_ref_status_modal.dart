class ContactRefStatusModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  bool? responseDialogRefrence;
  int? responseCount;
  String? responseMsg;

  ContactRefStatusModal(
      {this.responseCode,
      this.responseStatus,
      this.responseData,
      this.responseDialogRefrence,
      this.responseCount,
      this.responseMsg});

  ContactRefStatusModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseData = json['response_data'] != null ? new ResponseData.fromJson(json['response_data']) : null;
    responseDialogRefrence = json['response_dialog_refrence'];
    responseCount = json['response_count'];
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    data['response_dialog_refrence'] = this.responseDialogRefrence;
    data['response_count'] = this.responseCount;
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class ResponseData {
  bool? refrence1;
  bool? refrence2;
  bool? refrence3;
  bool? refrence4;
  bool? refrence5;

  ResponseData({this.refrence1, this.refrence2, this.refrence3, this.refrence4, this.refrence5});

  ResponseData.fromJson(Map<String, dynamic> json) {
    refrence1 = json['refrence1'];
    refrence2 = json['refrence2'];
    refrence3 = json['refrence3'];
    refrence4 = json['refrence4'];
    refrence5 = json['refrence5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refrence1'] = this.refrence1;
    data['refrence2'] = this.refrence2;
    data['refrence3'] = this.refrence3;
    data['refrence4'] = this.refrence4;
    data['refrence5'] = this.refrence5;
    return data;
  }
}
