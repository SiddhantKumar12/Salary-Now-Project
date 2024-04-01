class UserCommonModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  UserCommonModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  UserCommonModal.fromJson(Map<String, dynamic> json) {
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
  List<Gender>? gender;
  List<Marital>? marital;
  List<Accomadation>? accomadation;
  List<Qualification>? qualification;

  ResponseData({this.gender, this.marital, this.accomadation, this.qualification});

  ResponseData.fromJson(Map<String, dynamic> json) {
    if (json['gender'] != null) {
      gender = <Gender>[];
      json['gender'].forEach((v) {
        gender!.add(new Gender.fromJson(v));
      });
    }
    if (json['marital'] != null) {
      marital = <Marital>[];
      json['marital'].forEach((v) {
        marital!.add(new Marital.fromJson(v));
      });
    }
    if (json['accomadation'] != null) {
      accomadation = <Accomadation>[];
      json['accomadation'].forEach((v) {
        accomadation!.add(new Accomadation.fromJson(v));
      });
    }
    if (json['qualification'] != null) {
      qualification = <Qualification>[];
      json['qualification'].forEach((v) {
        qualification!.add(new Qualification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gender != null) {
      data['gender'] = this.gender!.map((v) => v.toJson()).toList();
    }
    if (this.marital != null) {
      data['marital'] = this.marital!.map((v) => v.toJson()).toList();
    }
    if (this.accomadation != null) {
      data['accomadation'] = this.accomadation!.map((v) => v.toJson()).toList();
    }
    if (this.qualification != null) {
      data['qualification'] = this.qualification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gender {
  String? id;
  String? name;

  Gender({this.id, this.name});

  Gender.fromJson(Map<String, dynamic> json) {
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

class Marital {
  String? id;
  String? name;

  Marital({this.id, this.name});

  Marital.fromJson(Map<String, dynamic> json) {
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

class Qualification {
  String? id;
  String? name;

  Qualification({this.id, this.name});

  Qualification.fromJson(Map<String, dynamic> json) {
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

class Accomadation {
  String? id;
  String? name;

  Accomadation({this.id, this.name});

  Accomadation.fromJson(Map<String, dynamic> json) {
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
