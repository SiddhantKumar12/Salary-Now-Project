class BankDetailsModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  BankDetailsModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  BankDetailsModal.fromJson(Map<String, dynamic> json) {
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
  String? usersId;
  String? token;
  String? bankid;
  String? bankName;
  String? branchName;
  String? ifsc;
  String? accountNo;

  ResponseData({this.usersId, this.token, this.bankid, this.bankName, this.branchName, this.ifsc, this.accountNo});

  ResponseData.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    token = json['token'];
    bankid = json['bankid'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    ifsc = json['ifsc'];
    accountNo = json['account_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['token'] = this.token;
    data['bankid'] = this.bankid;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['ifsc'] = this.ifsc;
    data['account_no'] = this.accountNo;
    return data;
  }
}
