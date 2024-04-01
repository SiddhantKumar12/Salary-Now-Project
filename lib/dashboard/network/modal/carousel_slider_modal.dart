class CarouselSliderModal {
  int? responseCode;
  int? responseStatus;
  ResponseData? responseData;
  String? responseMsg;

  CarouselSliderModal({this.responseCode, this.responseStatus, this.responseData, this.responseMsg});

  CarouselSliderModal.fromJson(Map<String, dynamic> json) {
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
  bool? bannerStatus;
  List<String>? banners;
  int? bannerCount;

  ResponseData({this.bannerStatus, this.banners, this.bannerCount});

  ResponseData.fromJson(Map<String, dynamic> json) {
    bannerStatus = json['banner_status'];
    banners = json['banners'].cast<String>();
    bannerCount = json['banner_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_status'] = this.bannerStatus;
    data['banners'] = this.banners;
    data['banner_count'] = this.bannerCount;
    return data;
  }
}
