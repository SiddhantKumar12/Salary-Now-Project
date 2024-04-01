class ApplyLoanModal {
  String? loanAmt;
  String? loanTeneur;
  String? interestAmt;
  String? totalPayAmount;
  String? loanPurpose;
  String? productId;

  ApplyLoanModal(
      {this.loanAmt, this.loanTeneur, this.interestAmt, this.totalPayAmount, this.loanPurpose, this.productId});

  ApplyLoanModal.fromJson(Map<String, dynamic> json) {
    loanAmt = json['loan_amt'];
    loanTeneur = json['loan_teneur'];
    interestAmt = json['interest_amt'];
    totalPayAmount = json['Total_Pay_Amount'];
    loanPurpose = json['loan_purpose'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_amt'] = this.loanAmt;
    data['loan_teneur'] = this.loanTeneur;
    data['interest_amt'] = this.interestAmt;
    data['Total_Pay_Amount'] = this.totalPayAmount;
    data['loan_purpose'] = this.loanPurpose;
    data['productId'] = this.productId;
    return data;
  }
}
