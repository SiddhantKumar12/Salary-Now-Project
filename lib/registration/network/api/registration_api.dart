import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../service_helper/api/api_strings.dart';

part 'registration_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class RegistrationApi {
  factory RegistrationApi(Dio dio) = _RegistrationApi;

  @POST(ApiStrings.registration)
  Future<HttpResponse> registerUser(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.pinCode)
  Future<HttpResponse> postPinCode(@Body() Map<String, dynamic> data);

  @GET(ApiStrings.employmentType)
  Future<HttpResponse> getEmploymentType();

  @POST(ApiStrings.panCardValidate)
  Future<HttpResponse> postPanCard(@Body() Map<String, dynamic> data);

  @GET(ApiStrings.state)
  Future<HttpResponse> getState();

  @POST(ApiStrings.cityList)
  Future<HttpResponse> postCityId(@Body() Map<String, dynamic> data);
}
