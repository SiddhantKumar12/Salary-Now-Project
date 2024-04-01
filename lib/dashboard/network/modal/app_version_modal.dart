class AppVersionModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  AppVersionModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  AppVersionModal.fromJson(Map<String, dynamic> json) {
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
  String? version;
  String? serverversion;
  String? status;
  String? versionOld;

  ResponseData({this.id, this.version, this.serverversion, this.status, this.versionOld});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    serverversion = json['serverversion'];
    status = json['status'];
    versionOld = json['version_old'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['version'] = this.version;
    data['serverversion'] = this.serverversion;
    data['status'] = this.status;
    data['version_old'] = this.versionOld;
    return data;
  }
}
