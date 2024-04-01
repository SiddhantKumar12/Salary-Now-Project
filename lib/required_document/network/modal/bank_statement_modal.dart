class BankStatementModal {
  int? responseCode;
  int? responseStatus;
  List<Data>? data;
  String? responseMsg;

  BankStatementModal({this.responseCode, this.responseStatus, this.data, this.responseMsg});

  BankStatementModal.fromJson(Map<String, dynamic> json) {
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
  String? bankStatementFile;
  String? fromDate;
  String? toDate;

  Data({this.bankStatementFile, this.fromDate, this.toDate});

  Data.fromJson(Map<String, dynamic> json) {
    bankStatementFile = json['bank_statement_file'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_statement_file'] = this.bankStatementFile;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}
