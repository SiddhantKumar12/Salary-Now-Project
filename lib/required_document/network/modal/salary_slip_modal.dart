class SalarySlipModal {
  int? responseCode;
  int? responseStatus;
  List<Data>? data;
  String? responseMsg;

  SalarySlipModal({this.responseCode, this.responseStatus, this.data, this.responseMsg});

  SalarySlipModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class Data {
  bool? status;
  String? month;
  String? url;

  Data({this.status, this.month, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    month = json['month'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['month'] = this.month;
    data['url'] = this.url;
    return data;
  }
}
