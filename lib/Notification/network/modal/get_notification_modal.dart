class NotificationGetModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  NotificationGetModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  NotificationGetModal.fromJson(Map<String, dynamic> json) {
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
  String? mobile;
  String? title;
  String? message;
  String? insertdatetime;

  ResponseData({this.id, this.mobile, this.title, this.message, this.insertdatetime});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    title = json['title'];
    message = json['message'];
    insertdatetime = json['insertdatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['title'] = this.title;
    data['message'] = this.message;
    data['insertdatetime'] = this.insertdatetime;
    return data;
  }
}
