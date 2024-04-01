class MySmsModal {
  String? id;
  String? phone;
  String? message;
  String? messageType;
  String? smsDate;

  MySmsModal({this.id, this.phone, this.message, this.messageType, this.smsDate});

  MySmsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    message = json['message'];
    messageType = json['messageType'];
    smsDate = json['SMS_Date_Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['SMS_Date_Time'] = this.smsDate;
    return data;
  }
}
