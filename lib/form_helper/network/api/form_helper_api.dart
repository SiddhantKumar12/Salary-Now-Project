import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../service_helper/api/api_strings.dart';

part 'form_helper_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class FormHelperApi {
  factory FormHelperApi(Dio dio) = _FormHelperApi;

  @GET(ApiStrings.employmentType)
  Future<HttpResponse> getEmploymentType();

  @GET(ApiStrings.state)
  Future<HttpResponse> getState();

  @GET(ApiStrings.salaryMode)
  Future<HttpResponse> getSalaryMode();

  @GET(ApiStrings.userCommon)
  Future<HttpResponse> getUserCommon();

  @GET(ApiStrings.bankList)
  Future<HttpResponse> postBankList();

  @POST(ApiStrings.pinCode)
  Future<HttpResponse> postPinCode(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.cityList)
  Future<HttpResponse> postCityId(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.ifsc)
  Future<HttpResponse> postifsc(@Body() Map<String, dynamic> data);
}
