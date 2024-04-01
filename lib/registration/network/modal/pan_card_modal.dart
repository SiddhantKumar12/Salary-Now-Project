class PanCardModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  PanCardModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  PanCardModal.fromJson(Map<String, dynamic> json) {
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
  Data? data;
  int? statusCode;
  bool? success;
  Null? message;
  String? messageCode;

  ResponseData({this.data, this.statusCode, this.success, this.message, this.messageCode});

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    success = json['success'];
    message = json['message'];
    messageCode = json['message_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    data['message_code'] = this.messageCode;
    return data;
  }
}

class Data {
  String? clientId;
  String? panNumber;
  String? fullName;
  String? category;

  Data({this.clientId, this.panNumber, this.fullName, this.category});

  Data.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    panNumber = json['pan_number'];
    fullName = json['full_name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['pan_number'] = this.panNumber;
    data['full_name'] = this.fullName;
    data['category'] = this.category;
    return data;
  }
}
