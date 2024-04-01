import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../../service_helper/api/api_strings.dart';

part 'personal_details_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class PersonalDetailsApi {
  factory PersonalDetailsApi(Dio dio) = _PersonalDetailsApi;

  @GET(ApiStrings.personalDetails)
  Future<HttpResponse> getPersonalDetails();

  @PATCH(ApiStrings.updatePersonalDetails)
  Future<HttpResponse> updatePersonalDetails(@Body() Map<String, dynamic> data);
}
