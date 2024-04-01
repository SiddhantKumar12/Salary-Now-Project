class CityModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  CityModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  CityModal.fromJson(Map<String, dynamic> json) {
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
  String? cityId;
  String? city;
  String? stateId;
  String? status;
  String? reportCity;

  ResponseData({this.cityId, this.city, this.stateId, this.status, this.reportCity});

  ResponseData.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    city = json['city'];
    stateId = json['state_id'];
    status = json['status'];
    reportCity = json['report_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['state_id'] = this.stateId;
    data['status'] = this.status;
    data['report_city'] = this.reportCity;
    return data;
  }
}
