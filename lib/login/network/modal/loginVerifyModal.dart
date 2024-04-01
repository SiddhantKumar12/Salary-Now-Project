class LoginVerifyModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  LoginVerifyModal(
      {this.responseCode,
        this.responseStatus,
        this.responseData,
        this.responseMsg});

  LoginVerifyModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseData = json['response_data'] != null
        ? new ResponseData.fromJson(json['response_data'])
        : null;
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
  String? userId;
  String? title;
  String? name;
  String? mName;
  String? lName;
  String? email;
  String? mobile;
  String? stateLocation;

  ResponseData(
      {this.id,
        this.userId,
        this.title,
        this.name,
        this.mName,
        this.lName,
        this.email,
        this.mobile,
        this.stateLocation});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    name = json['name'];
    mName = json['m_name'];
    lName = json['l_name'];
    email = json['email'];
    mobile = json['mobile'];
    stateLocation = json['state_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['name'] = this.name;
    data['m_name'] = this.mName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['state_location'] = this.stateLocation;
    return data;
  }
}