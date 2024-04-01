class PackagesModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  PackagesModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  PackagesModal.fromJson(Map<String, dynamic> json) {
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
  String? companyId;
  String? productType;
  String? productName;
  String? productCode;
  String? days;
  String? numOfEmi;
  String? instrest;
  String? pelanaty;
  String? processFee;
  String? processFeeType;
  String? gstFee;
  String? preCloser;
  String? bounceCharge;
  String? extraCharge;
  String? maxAmount;
  String? customerType;
  String? cibil;
  String? city;
  String? internalScore;
  String? contact;
  String? sms;
  String? productDescription;
  String? isDisplay;
  String? loanRegistrationCharges;
  String? gSTOnRegFees;
  String? maintenanceFees;
  String? maintenanceFeesRate;
  String? convenienceCharges;
  String? convenienceChargesRate;
  String? eligibilityInterest;
  String? annualisedIRR;

  ResponseData(
      {this.id,
      this.companyId,
      this.productType,
      this.productName,
      this.productCode,
      this.days,
      this.numOfEmi,
      this.instrest,
      this.pelanaty,
      this.processFee,
      this.processFeeType,
      this.gstFee,
      this.preCloser,
      this.bounceCharge,
      this.extraCharge,
      this.maxAmount,
      this.customerType,
      this.cibil,
      this.city,
      this.internalScore,
      this.contact,
      this.sms,
      this.productDescription,
      this.isDisplay,
      this.loanRegistrationCharges,
      this.gSTOnRegFees,
      this.maintenanceFees,
      this.maintenanceFeesRate,
      this.convenienceCharges,
      this.convenienceChargesRate,
      this.eligibilityInterest,
      this.annualisedIRR});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    productType = json['productType'];
    productName = json['productName'];
    productCode = json['productCode'];
    days = json['days'];
    numOfEmi = json['numOfEmi'];
    instrest = json['instrest'];
    pelanaty = json['pelanaty'];
    processFee = json['processFee'];
    processFeeType = json['processFeeType'];
    gstFee = json['gstFee'];
    preCloser = json['preCloser'];
    bounceCharge = json['bounceCharge'];
    extraCharge = json['extraCharge'];
    maxAmount = json['maxAmount'];
    customerType = json['customerType'];
    cibil = json['cibil'];
    city = json['city'];
    internalScore = json['internalScore'];
    contact = json['contact'];
    sms = json['sms'];
    productDescription = json['productDescription'];
    isDisplay = json['isDisplay'];
    loanRegistrationCharges = json['loanRegistrationCharges'];
    gSTOnRegFees = json['gSTOnRegFees'];
    maintenanceFees = json['maintenanceFees'];
    maintenanceFeesRate = json['maintenanceFeesRate'];
    convenienceCharges = json['convenienceCharges'];
    convenienceChargesRate = json['convenienceChargesRate'];
    eligibilityInterest = json['eligibilityInterest'];
    annualisedIRR = json['annualisedIRR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    data['productType'] = this.productType;
    data['productName'] = this.productName;
    data['productCode'] = this.productCode;
    data['days'] = this.days;
    data['numOfEmi'] = this.numOfEmi;
    data['instrest'] = this.instrest;
    data['pelanaty'] = this.pelanaty;
    data['processFee'] = this.processFee;
    data['processFeeType'] = this.processFeeType;
    data['gstFee'] = this.gstFee;
    data['preCloser'] = this.preCloser;
    data['bounceCharge'] = this.bounceCharge;
    data['extraCharge'] = this.extraCharge;
    data['maxAmount'] = this.maxAmount;
    data['customerType'] = this.customerType;
    data['cibil'] = this.cibil;
    data['city'] = this.city;
    data['internalScore'] = this.internalScore;
    data['contact'] = this.contact;
    data['sms'] = this.sms;
    data['productDescription'] = this.productDescription;
    data['isDisplay'] = this.isDisplay;
    data['loanRegistrationCharges'] = this.loanRegistrationCharges;
    data['gSTOnRegFees'] = this.gSTOnRegFees;
    data['maintenanceFees'] = this.maintenanceFees;
    data['maintenanceFeesRate'] = this.maintenanceFeesRate;
    data['convenienceCharges'] = this.convenienceCharges;
    data['convenienceChargesRate'] = this.convenienceChargesRate;
    data['eligibilityInterest'] = this.eligibilityInterest;
    data['annualisedIRR'] = this.annualisedIRR;
    return data;
  }
}
