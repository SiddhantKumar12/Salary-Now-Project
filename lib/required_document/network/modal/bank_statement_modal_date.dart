class BankStatementDateModal {
  int? responseCode;
  int? responseStatus;
  Data? data;
  String? responseMsg;

  BankStatementDateModal({this.responseCode, this.responseStatus, this.data, this.responseMsg});

  BankStatementDateModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class Data {
  String? showmessage;
  String? from;
  String? to;
  bool? uploadpdf;

  Data({this.showmessage, this.from, this.to});

  Data.fromJson(Map<String, dynamic> json) {
    showmessage = json['showmessage'];
    from = json['from'];
    to = json['to'];
    uploadpdf = json['uploadpdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showmessage'] = this.showmessage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['uploadpdf'] = this.uploadpdf;
    return data;
  }
}
