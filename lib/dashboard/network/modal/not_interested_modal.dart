class NotInterestedModal {
  int? responseCode;
  int? responseStatus;
  String? responseMsg;
  List<ResponseData>? responseData;

  NotInterestedModal({this.responseCode, this.responseStatus, this.responseMsg, this.responseData});

  NotInterestedModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseMsg = json['response_msg'];
    if (json['response_data'] != null) {
      responseData = <ResponseData>[];
      json['response_data'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    data['response_msg'] = this.responseMsg;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  String? id;
  String? message;

  ResponseData({this.id, this.message});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    return data;
  }
}
