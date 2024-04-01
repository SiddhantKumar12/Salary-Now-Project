class IfscModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  IfscModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  IfscModal.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? bankName;
  String? ifsc;
  String? office;
  String? address;
  String? district;
  String? city;
  String? state;
  String? phone;

  ResponseData(
      {this.id, this.bankName, this.ifsc, this.office, this.address, this.district, this.city, this.state, this.phone});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    ifsc = json['ifsc'];
    office = json['office'];
    address = json['address'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['office'] = this.office;
    data['address'] = this.address;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['phone'] = this.phone;
    return data;
  }
}
