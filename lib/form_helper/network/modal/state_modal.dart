class StateModal {
  int? responseCode;
  int? responseStatus;
  List<ResponseData>? responseData;
  String? responseMsg;

  StateModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  StateModal.fromJson(Map<String, dynamic> json) {
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
  String? stateId;
  String? state;
  String? status;
  String? stateCode;
  String? cibilStateId;

  ResponseData({this.stateId, this.state, this.status, this.stateCode, this.cibilStateId});

  ResponseData.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    state = json['state'];
    status = json['status'];
    stateCode = json['state_code'];
    cibilStateId = json['cibil_state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    data['status'] = this.status;
    data['state_code'] = this.stateCode;
    data['cibil_state_id'] = this.cibilStateId;
    return data;
  }
}
