class LoanCalculatorModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  LoanCalculatorModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  LoanCalculatorModal.fromJson(Map<String, dynamic> json) {
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
  String? maxAmount;
  String? totalAPR;
  // int? processingfees;
  String? interestRate;
  int? totalPayAmount;
  String? loanTenure;
  int? interestAmt;
  int? monthlyPayment;
  List<EmiData>? emiData;

  ResponseData(
      {this.maxAmount,
      this.totalAPR,
      // this.processingfees,
      this.interestRate,
      this.totalPayAmount,
      this.loanTenure,
      this.interestAmt,
      this.monthlyPayment,
      this.emiData});

  ResponseData.fromJson(Map<String, dynamic> json) {
    maxAmount = json['max_amount'];
    totalAPR = json['Total_APR'];
    // processingfees = json['processingfees'];
    interestRate = json['interest_rate'];
    totalPayAmount = json['Total_Pay_Amount'];
    loanTenure = json['loan_tenure'];
    interestAmt = json['interest_amt'];
    monthlyPayment = json['monthly_payment'];
    if (json['emi_data'] != null) {
      emiData = <EmiData>[];
      json['emi_data'].forEach((v) {
        emiData!.add(new EmiData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_amount'] = this.maxAmount;
    data['Total_APR'] = this.totalAPR;
    // data['processingfees'] = this.processingfees;
    data['interest_rate'] = this.interestRate;
    data['Total_Pay_Amount'] = this.totalPayAmount;
    data['loan_tenure'] = this.loanTenure;
    data['interest_amt'] = this.interestAmt;
    data['monthly_payment'] = this.monthlyPayment;
    if (this.emiData != null) {
      data['emi_data'] = this.emiData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmiData {
  String? emiMonth;
  String? emiPrincipal;
  String? emiInterest;
  String? monthlyEmiAmount;

  EmiData({this.emiMonth, this.emiPrincipal, this.emiInterest, this.monthlyEmiAmount});

  EmiData.fromJson(Map<String, dynamic> json) {
    emiMonth = json['emi_month'];
    emiPrincipal = json['emi_principal'];
    emiInterest = json['emi_interest'];
    monthlyEmiAmount = json['monthly_emi_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emi_month'] = this.emiMonth;
    data['emi_principal'] = this.emiPrincipal;
    data['emi_interest'] = this.emiInterest;
    data['monthly_emi_amount'] = this.monthlyEmiAmount;
    return data;
  }
}
