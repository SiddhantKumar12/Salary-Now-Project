class PreviousLoanModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  PreviousLoanModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  PreviousLoanModal.fromJson(Map<String, dynamic> json) {
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
  String? applyLoanDataId;
  String? loanNo;
  String? loanAmount;
  String? approvedTeneur;
  String? loanClosedDate;
  String? agreementStatus;
  String? agreementUrl;
  String? sanctionStatus;
  String? sanctionUrl;

  ResponseData(
      {this.applyLoanDataId,
      this.loanNo,
      this.loanAmount,
      this.approvedTeneur,
      this.loanClosedDate,
      this.agreementStatus,
      this.agreementUrl,
      this.sanctionStatus,
      this.sanctionUrl});

  ResponseData.fromJson(Map<String, dynamic> json) {
    applyLoanDataId = json['applyLoanDataId'];
    loanNo = json['loanNo'];
    loanAmount = json['LoanAmount'];
    approvedTeneur = json['approved_teneur'];
    loanClosedDate = json['loanClosedDate'];
    agreementStatus = json['agreement_status'];
    agreementUrl = json['agreement_url'];
    sanctionStatus = json['sanction_status'];
    sanctionUrl = json['sanction_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applyLoanDataId'] = this.applyLoanDataId;
    data['loanNo'] = this.loanNo;
    data['LoanAmount'] = this.loanAmount;
    data['approved_teneur'] = this.approvedTeneur;
    data['loanClosedDate'] = this.loanClosedDate;
    data['agreement_status'] = this.agreementStatus;
    data['agreement_url'] = this.agreementUrl;
    data['sanction_status'] = this.sanctionStatus;
    data['sanction_url'] = this.sanctionUrl;
    return data;
  }
}
