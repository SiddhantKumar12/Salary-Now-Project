import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../../service_helper/api/api_strings.dart';

part 'residential_details_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class ResidentialDetailsApi {
  factory ResidentialDetailsApi(Dio dio) = _ResidentialDetailsApi;

  @GET(ApiStrings.residentialDetails)
  Future<HttpResponse> getResidentialDetails();

  @PATCH(ApiStrings.updateResidentialDetails)
  Future<HttpResponse> updateResidentialDetails(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.aadhaarOtp)
  Future<HttpResponse> postAadhaarOTP(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.aadhaarValidate)
  Future<HttpResponse> postAadhaarVerification(@Body() Map<String, dynamic> data);
}
