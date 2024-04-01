class LoanChargesModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  LoanChargesModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  LoanChargesModal.fromJson(Map<String, dynamic> json) {
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
  List<Emidata>? emidata;
  int? mininumDueAmount;
  int? othercharges;
  int? penalBalanceamount;
  int? overdueBalanceamount;
  int? bcBalanceamount;
  int? totalInterest;
  int? paymentStatus;
  bool? paybtn;
  String? mandateStatus;
  String? isProduct;
  String? loanStatus;
  bool? chargesShow;
  Data? data;

  ResponseData(
      {this.emidata,
      this.mininumDueAmount,
      this.othercharges,
      this.penalBalanceamount,
      this.overdueBalanceamount,
      this.bcBalanceamount,
      this.totalInterest,
      this.paymentStatus,
      this.paybtn,
      this.mandateStatus,
      this.isProduct,
      this.loanStatus,
      this.chargesShow,
      this.data});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['emidata'] != null) {
      emidata = <Emidata>[];
      json['emidata'].forEach((v) {
        emidata!.add(new Emidata.fromJson(v));
      });
    }
    mininumDueAmount = json['mininumDueAmount'];
    othercharges = json['othercharges'];
    penalBalanceamount = json['PenalBalanceamount'];
    overdueBalanceamount = json['overdueBalanceamount'];
    bcBalanceamount = json['bcBalanceamount'];
    totalInterest = json['total_interest'];
    paymentStatus = json['payment_status'];
    paybtn = json['paybtn'];
    mandateStatus = json['mandateStatus'];
    isProduct = json['isProduct'];
    loanStatus = json['loanStatus'];
    chargesShow = json['charges_show'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.emidata != null) {
      data['emidata'] = this.emidata!.map((v) => v.toJson()).toList();
    }
    data['mininumDueAmount'] = this.mininumDueAmount;
    data['othercharges'] = this.othercharges;
    data['PenalBalanceamount'] = this.penalBalanceamount;
    data['overdueBalanceamount'] = this.overdueBalanceamount;
    data['bcBalanceamount'] = this.bcBalanceamount;
    data['total_interest'] = this.totalInterest;
    data['payment_status'] = this.paymentStatus;
    data['paybtn'] = this.paybtn;
    data['mandateStatus'] = this.mandateStatus;
    data['isProduct'] = this.isProduct;
    data['loanStatus'] = this.loanStatus;
    data['charges_show'] = this.chargesShow;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Emidata {
  String? eMI;
  int? amount;
  int? emiAmount;
  int? emiFixed;
  String? duedate;
  int? overdue;
  String? status;
  dynamic penalBalanceAmount;
  dynamic overdueBalanceAmount;
  int? bounceCharge;
  dynamic otherCharge;

  Emidata(
      {this.eMI,
      this.amount,
      this.emiAmount,
      this.emiFixed,
      this.duedate,
      this.overdue,
      this.status,
      this.penalBalanceAmount,
      this.overdueBalanceAmount,
      this.bounceCharge,
      this.otherCharge});

  Emidata.fromJson(Map<String, dynamic> json) {
    eMI = json['EMI'];
    amount = json['amount'];
    emiAmount = json['emi_amount'];
    emiFixed = json['emi_fixed'];
    duedate = json['duedate'];
    overdue = json['overdue'];
    status = json['status'];
    penalBalanceAmount = json['PenalBalanceAmount'];
    overdueBalanceAmount = json['overdueBalanceAmount'];
    bounceCharge = json['bounceCharge'];
    otherCharge = json['otherCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMI'] = this.eMI;
    data['amount'] = this.amount;
    data['emi_amount'] = this.emiAmount;
    data['emi_fixed'] = this.emiFixed;
    data['duedate'] = this.duedate;
    data['overdue'] = this.overdue;
    data['status'] = this.status;
    data['PenalBalanceAmount'] = this.penalBalanceAmount;
    data['overdueBalanceAmount'] = this.overdueBalanceAmount;
    data['bounceCharge'] = this.bounceCharge;
    data['otherCharge'] = this.otherCharge;
    return data;
  }
}

class Data {
  String? applyLoanDataId;
  String? status;
  String? loanAmt;
  String? loanId;
  String? loanTeneur;
  String? interestAmt;
  String? totalPayAmount;
  String? agreementStatus;
  String? dpdDays;
  String? approvedTeneur;
  String? approvedAmt;
  String? createdDate;
  String? sanctionStatus;
  String? disbursedDate;
  String? paidDate;
  String? latePenaltyDay;
  String? totalAmountWithPenalty;
  String? newDate;
  String? newDueAmount;
  String? emandateDueAmount;
  String? productId;
  String? totaldays;
  String? saveamount;
  String? dismsg;
  int? todayDueAmount;
  String? msg;
  String? agreementUrl;
  String? sanctionUrl;

  Data(
      {this.applyLoanDataId,
      this.status,
      this.loanAmt,
      this.loanId,
      this.loanTeneur,
      this.interestAmt,
      this.totalPayAmount,
      this.agreementStatus,
      this.dpdDays,
      this.approvedTeneur,
      this.approvedAmt,
      this.createdDate,
      this.sanctionStatus,
      this.disbursedDate,
      this.paidDate,
      this.latePenaltyDay,
      this.totalAmountWithPenalty,
      this.newDate,
      this.newDueAmount,
      this.emandateDueAmount,
      this.productId,
      this.totaldays,
      this.saveamount,
      this.dismsg,
      this.todayDueAmount,
      this.msg,
      this.agreementUrl,
      this.sanctionUrl});

  Data.fromJson(Map<String, dynamic> json) {
    applyLoanDataId = json['apply_loan_data_id'];
    status = json['status'];
    loanAmt = json['loan_amt'];
    loanId = json['loan_id'];
    loanTeneur = json['loan_teneur'];
    interestAmt = json['interest_amt'];
    totalPayAmount = json['Total_Pay_Amount'];
    agreementStatus = json['agreement_status'];
    dpdDays = json['dpd_days'];
    approvedTeneur = json['approved_teneur'];
    approvedAmt = json['approved_amt'];
    createdDate = json['created_date'];
    sanctionStatus = json['sanction_status'];
    disbursedDate = json['disbursed_date'];
    paidDate = json['paid_date'];
    latePenaltyDay = json['LatePenaltyDay'];
    totalAmountWithPenalty = json['TotalAmountWithPenalty'];
    newDate = json['newDate'];
    newDueAmount = json['newDueAmount'];
    emandateDueAmount = json['emandateDueAmount'];
    productId = json['productId'];
    totaldays = json['totaldays'];
    saveamount = json['saveamount'];
    dismsg = json['dismsg'];
    todayDueAmount = json['todayDueAmount'];
    msg = json['msg'];
    agreementUrl = json['agreement_url'];
    sanctionUrl = json['sanction_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apply_loan_data_id'] = this.applyLoanDataId;
    data['status'] = this.status;
    data['loan_amt'] = this.loanAmt;
    data['loan_id'] = this.loanId;
    data['loan_teneur'] = this.loanTeneur;
    data['interest_amt'] = this.interestAmt;
    data['Total_Pay_Amount'] = this.totalPayAmount;
    data['agreement_status'] = this.agreementStatus;
    data['dpd_days'] = this.dpdDays;
    data['approved_teneur'] = this.approvedTeneur;
    data['approved_amt'] = this.approvedAmt;
    data['created_date'] = this.createdDate;
    data['sanction_status'] = this.sanctionStatus;
    data['disbursed_date'] = this.disbursedDate;
    data['paid_date'] = this.paidDate;
    data['LatePenaltyDay'] = this.latePenaltyDay;
    data['TotalAmountWithPenalty'] = this.totalAmountWithPenalty;
    data['newDate'] = this.newDate;
    data['newDueAmount'] = this.newDueAmount;
    data['emandateDueAmount'] = this.emandateDueAmount;
    data['productId'] = this.productId;
    data['totaldays'] = this.totaldays;
    data['saveamount'] = this.saveamount;
    data['dismsg'] = this.dismsg;
    data['todayDueAmount'] = this.todayDueAmount;
    data['msg'] = this.msg;
    data['agreement_url'] = this.agreementUrl;
    data['sanction_url'] = this.sanctionUrl;
    return data;
  }
}
