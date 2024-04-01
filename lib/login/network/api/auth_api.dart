import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../service_helper/api/api_strings.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(ApiStrings.authLogin)
  Future<HttpResponse> loginUser(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.verifyOtp)
  Future<HttpResponse> verifyUser(@Body() Map<String, dynamic> data);
}
