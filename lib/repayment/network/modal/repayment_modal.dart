class RepaymentModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  RepaymentModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  RepaymentModal.fromJson(Map<String, dynamic> json) {
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
  String? loanNo;
  int? paymentStatus;
  int? totalInterest;
  String? totalAmountWithPenalty;
  String? approvedTeneur;
  String? paidDate;
  List<EmiData>? emiData;

  ResponseData(
      {this.loanNo,
      this.paymentStatus,
      this.totalInterest,
      this.totalAmountWithPenalty,
      this.approvedTeneur,
      this.paidDate,
      this.emiData});

  ResponseData.fromJson(Map<String, dynamic> json) {
    loanNo = json['loan_no'];
    paymentStatus = json['payment_status'];
    totalInterest = json['total_interest'];
    totalAmountWithPenalty = json['TotalAmountWithPenalty'];
    approvedTeneur = json['approved_teneur'];
    paidDate = json['paid_date'];
    if (json['emi_data'] != null) {
      emiData = <EmiData>[];
      json['emi_data'].forEach((v) {
        emiData!.add(new EmiData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_no'] = this.loanNo;
    data['payment_status'] = this.paymentStatus;
    data['total_interest'] = this.totalInterest;
    data['TotalAmountWithPenalty'] = this.totalAmountWithPenalty;
    data['approved_teneur'] = this.approvedTeneur;
    data['paid_date'] = this.paidDate;
    if (this.emiData != null) {
      data['emi_data'] = this.emiData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmiData {
  int? emiMonth;
  String? emiPrincipal;
  String? emiInterest;
  String? monthlyEmiAmount;
  String? emiDueDate;
  String? emiStatus;

  EmiData({this.emiMonth, this.emiPrincipal, this.emiInterest, this.monthlyEmiAmount, this.emiDueDate, this.emiStatus});

  EmiData.fromJson(Map<String, dynamic> json) {
    emiMonth = json['emi_month'];
    emiPrincipal = json['emi_principal'];
    emiInterest = json['emi_interest'];
    monthlyEmiAmount = json['monthly_emi_amount'];
    emiDueDate = json['emi_due_date'];
    emiStatus = json['emi_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emi_month'] = this.emiMonth;
    data['emi_principal'] = this.emiPrincipal;
    data['emi_interest'] = this.emiInterest;
    data['monthly_emi_amount'] = this.monthlyEmiAmount;
    data['emi_due_date'] = this.emiDueDate;
    data['emi_status'] = this.emiStatus;
    return data;
  }
}
