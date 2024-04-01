import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../service_helper/api/api_strings.dart';

part 'profile_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class ProfileApi {
  factory ProfileApi(Dio dio) = _ProfileApi;

  @GET(ApiStrings.profile)
  Future<HttpResponse> getProfile();

  @POST(ApiStrings.cancelMandate)
  Future<HttpResponse> postCancelMandate(@Body() Map<String, dynamic> data);
}
