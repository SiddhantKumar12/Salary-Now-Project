import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../service_helper/api/api_strings.dart';

part 'dashboard_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class DashboardAPi {
  factory DashboardAPi(Dio dio) = _DashboardAPi;

  @GET(ApiStrings.dashBoard)
  Future<HttpResponse> getDashBoardData();

  @GET(ApiStrings.reqCallback)
  Future<HttpResponse> getReqCallback();

  @GET(ApiStrings.deleteReqCallback)
  Future<HttpResponse> getDeleteReqCallback();

  @GET(ApiStrings.loanAgreeOtp)
  Future<HttpResponse> getLoanAgreeOtp();

  @GET(ApiStrings.notInterested)
  Future<HttpResponse> getNotInterested();

  @GET(ApiStrings.caroselSlider)
  Future<HttpResponse> getCarouselSlider();

  @GET(ApiStrings.checkMicroUser)
  Future<HttpResponse> getCheckMicroUser();

  @GET(ApiStrings.userReligion)
  Future<HttpResponse> getUserReligion();

  @GET(ApiStrings.appStatus)
  Future<HttpResponse> getAppStatus();

  @GET(ApiStrings.appVersion)
  Future<HttpResponse> getAppVersion();

  @GET(ApiStrings.getFaq)
  Future<HttpResponse> getFAQ();

  @GET(ApiStrings.getNotification)
  Future<HttpResponse> getNotification();

  @POST(ApiStrings.postFaq)
  Future<HttpResponse> postFAQ(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.getDocument)
  Future<HttpResponse> getDocument(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.loanSanctionPdf)
  Future<HttpResponse> postSanctionPdf(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.loanAgreeOtpVerify)
  Future<HttpResponse> loanOtpVerify(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.postNotInterested)
  Future<HttpResponse> postNotInterested(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.updateMicroStatus)
  Future<HttpResponse> postMicroStatus(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.microUserGetDisclaimer)
  Future<HttpResponse> postMicroDisclaimer(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.microUserPostDisclaimer)
  Future<HttpResponse> postMicroUserDisclaimer(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.microUserSave)
  Future<HttpResponse> postMicroUserSave(@Body() Map<String, dynamic> data);
}
