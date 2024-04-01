class DashBoardModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  bool? responseLoanStatus;
  String? responseMsg;

  DashBoardModal(
      {this.responseCode, this.responseStatus, this.responseData, this.responseLoanStatus, this.responseMsg});

  DashBoardModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseData = json['response_data'] != null ? new ResponseData.fromJson(json['response_data']) : null;
    responseLoanStatus = json['response_loan_status'];
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    data['response_loan_status'] = this.responseLoanStatus;
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class ResponseData {
  String? rejectStatus;
  int? rejectDays;
  String? rejectMsg;
  bool? loctionApi;
  String? agreementStatus;
  String? sanctionStatus;
  String? agreement;
  String? aggrementFile;
  bool? mandatestatus;
  bool? mandatecancelbtn;
  LoanDetails? loanDetails;

  ResponseData(
      {this.rejectStatus,
      this.rejectDays,
      this.rejectMsg,
      this.loctionApi,
      this.agreementStatus,
      this.sanctionStatus,
      this.agreement,
      this.aggrementFile,
      this.mandatestatus,
      this.mandatecancelbtn,
      this.loanDetails});

  ResponseData.fromJson(Map<String, dynamic> json) {
    rejectStatus = json['reject_status'];
    rejectDays = json['reject_days'];
    rejectMsg = json['reject_msg'];
    loctionApi = json['loction_api'];
    agreementStatus = json['agreement_status'];
    sanctionStatus = json['sanction_status'];
    agreement = json['agreement'];
    aggrementFile = json['aggrement_file'];
    mandatestatus = json['mandatestatus'];
    mandatecancelbtn = json['mandatecancelbtn'];
    loanDetails = json['loan_details'] != null ? new LoanDetails.fromJson(json['loan_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reject_status'] = this.rejectStatus;
    data['reject_days'] = this.rejectDays;
    data['reject_msg'] = this.rejectMsg;
    data['loction_api'] = this.loctionApi;
    data['agreement_status'] = this.agreementStatus;
    data['sanction_status'] = this.sanctionStatus;
    data['agreement'] = this.agreement;
    data['aggrement_file'] = this.aggrementFile;
    data['mandatestatus'] = this.mandatestatus;
    data['mandatecancelbtn'] = this.mandatecancelbtn;
    if (this.loanDetails != null) {
      data['loan_details'] = this.loanDetails!.toJson();
    }
    return data;
  }
}

class LoanDetails {
  String? createdDate;
  String? disbursedDate;
  String? paidDate;
  String? mandateStatus;
  String? loanNo;
  String? usersId;
  String? loanAmt;
  String? loanTeneur;
  String? lenderId;
  String? approvedAmt;
  String? emandateApproveAmount;
  String? approvedTeneur;
  String? interestAmt;
  String? dpdDays;
  String? disbursedAmount;
  String? pfee;
  String? gstamt;
  String? firstDueDate;
  String? updatedDate;
  String? status;
  String? agreementStatus;
  String? sanctionStatus;
  String? productId;
  String? emandateDueAmount;
  String? applyLoanDataId;
  String? totalPayAmount;
  int? saveamount;
  bool? displaymsg;
  String? msg;
  String? tenure;
  String? statusMessage;
  String? loanstatus;
  String? applicationNo;
  String? latePaymentCharges;

  LoanDetails(
      {this.createdDate,
      this.disbursedDate,
      this.paidDate,
      this.mandateStatus,
      this.loanNo,
      this.usersId,
      this.loanAmt,
      this.loanTeneur,
      this.lenderId,
      this.approvedAmt,
      this.emandateApproveAmount,
      this.approvedTeneur,
      this.interestAmt,
      this.dpdDays,
      this.disbursedAmount,
      this.pfee,
      this.gstamt,
      this.firstDueDate,
      this.updatedDate,
      this.status,
      this.agreementStatus,
      this.sanctionStatus,
      this.productId,
      this.emandateDueAmount,
      this.applyLoanDataId,
      this.totalPayAmount,
      this.saveamount,
      this.displaymsg,
      this.msg,
      this.tenure,
      this.statusMessage,
      this.loanstatus,
      this.applicationNo,
      this.latePaymentCharges});

  LoanDetails.fromJson(Map<String, dynamic> json) {
    createdDate = json['created_date'];
    disbursedDate = json['disbursed_date'];
    paidDate = json['paid_date'];
    mandateStatus = json['mandateStatus'];
    loanNo = json['loanNo'];
    usersId = json['users_id'];
    loanAmt = json['loan_amt'];
    loanTeneur = json['loan_teneur'];
    lenderId = json['lender_id'];
    approvedAmt = json['approved_amt'];
    emandateApproveAmount = json['emandateApproveAmount'];
    approvedTeneur = json['approved_teneur'];
    interestAmt = json['interest_amt'];
    dpdDays = json['dpd_days'];
    disbursedAmount = json['Disbursed_Amount'];
    pfee = json['pfee'];
    gstamt = json['gstamt'];
    firstDueDate = json['firstDueDate'];
    updatedDate = json['updated_date'];
    status = json['status'];
    agreementStatus = json['agreement_status'];
    sanctionStatus = json['sanction_status'];
    productId = json['productId'];
    emandateDueAmount = json['emandateDueAmount'];
    applyLoanDataId = json['apply_loan_data_id'];
    totalPayAmount = json['Total_Pay_Amount'];
    saveamount = json['saveamount'];
    displaymsg = json['displaymsg'];
    msg = json['msg'];
    tenure = json['tenure'];
    statusMessage = json['status_message'];
    loanstatus = json['loanstatus'];
    applicationNo = json['application_no'];
    latePaymentCharges = json['late_payment_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_date'] = this.createdDate;
    data['disbursed_date'] = this.disbursedDate;
    data['paid_date'] = this.paidDate;
    data['mandateStatus'] = this.mandateStatus;
    data['loanNo'] = this.loanNo;
    data['users_id'] = this.usersId;
    data['loan_amt'] = this.loanAmt;
    data['loan_teneur'] = this.loanTeneur;
    data['lender_id'] = this.lenderId;
    data['approved_amt'] = this.approvedAmt;
    data['emandateApproveAmount'] = this.emandateApproveAmount;
    data['approved_teneur'] = this.approvedTeneur;
    data['interest_amt'] = this.interestAmt;
    data['dpd_days'] = this.dpdDays;
    data['Disbursed_Amount'] = this.disbursedAmount;
    data['pfee'] = this.pfee;
    data['gstamt'] = this.gstamt;
    data['firstDueDate'] = this.firstDueDate;
    data['updated_date'] = this.updatedDate;
    data['status'] = this.status;
    data['agreement_status'] = this.agreementStatus;
    data['sanction_status'] = this.sanctionStatus;
    data['productId'] = this.productId;
    data['emandateDueAmount'] = this.emandateDueAmount;
    data['apply_loan_data_id'] = this.applyLoanDataId;
    data['Total_Pay_Amount'] = this.totalPayAmount;
    data['saveamount'] = this.saveamount;
    data['displaymsg'] = this.displaymsg;
    data['msg'] = this.msg;
    data['tenure'] = this.tenure;
    data['status_message'] = this.statusMessage;
    data['loanstatus'] = this.loanstatus;
    data['application_no'] = this.applicationNo;
    data['late_payment_charges'] = this.latePaymentCharges;
    return data;
  }
}
