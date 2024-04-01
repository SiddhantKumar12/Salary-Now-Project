class MyCallLogModal {
  String? phone;
  String? name;
  String? type;
  String? date;
  String? duration;

  MyCallLogModal({this.phone, this.name, this.type, this.date, this.duration});

  MyCallLogModal.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    type = json['type'];
    date = json['date'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['type'] = this.type;
    data['date'] = this.date;
    data['duration'] = this.duration;
    return data;
  }
}
