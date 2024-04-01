class BankListModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  BankListModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  BankListModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    if (json['response_data'] != null) {
      responseData = <ResponseData>[];
      json['response_data'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.map((v) => v.toJson()).toList();
    }
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class ResponseData {
  String? id;
  String? bankName;
  String? bankAnalysisCode;

  ResponseData({this.id, this.bankName, this.bankAnalysisCode});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['BankName'];
    bankAnalysisCode = json['bankAnalysisCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BankName'] = this.bankName;
    data['bankAnalysisCode'] = this.bankAnalysisCode;
    return data;
  }
}
