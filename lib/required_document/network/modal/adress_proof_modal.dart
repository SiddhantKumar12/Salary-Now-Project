class AddressProofModal {
  int? responseCode;
  int? responseStatus;
  Data? data;
  String? responseMsg;

  AddressProofModal({this.responseCode, this.responseStatus, this.data, this.responseMsg});

  AddressProofModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    responseMsg = json['response_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['response_msg'] = this.responseMsg;
    return data;
  }
}

class Data {
  String? front;
  String? back;
  DocType? docType;

  Data({this.front, this.back, this.docType});

  Data.fromJson(Map<String, dynamic> json) {
    front = json['front'];
    back = json['back'];
    docType = json['doc_type'] != null ? new DocType.fromJson(json['doc_type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front'] = this.front;
    data['back'] = this.back;
    if (this.docType != null) {
      data['doc_type'] = this.docType!.toJson();
    }
    return data;
  }
}

class DocType {
  String? id;
  String? name;

  DocType({this.id, this.name});

  DocType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
