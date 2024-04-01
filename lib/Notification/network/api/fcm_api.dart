import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../service_helper/api/api_strings.dart';

part 'fcm_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class FcmApi {
  factory FcmApi(Dio dio) = _FcmApi;

  @POST(ApiStrings.fcmToken)
  Future<HttpResponse> postFcmToken(@Body() Map<String, dynamic> data);
}
