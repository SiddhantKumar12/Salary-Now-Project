class SalaryModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  SalaryModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  SalaryModal.fromJson(Map<String, dynamic> json) {
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
  String? salaryModeId;
  String? name;
  String? createdDate;
  String? updatedDate;
  String? status;

  ResponseData({this.salaryModeId, this.name, this.createdDate, this.updatedDate, this.status});

  ResponseData.fromJson(Map<String, dynamic> json) {
    salaryModeId = json['salary_mode_id'];
    name = json['name'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salary_mode_id'] = this.salaryModeId;
    data['name'] = this.name;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['status'] = this.status;
    return data;
  }
}
