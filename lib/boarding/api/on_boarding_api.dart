import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../service_helper/api/api_strings.dart';

part 'on_boarding_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class OnBoardingApi {
  factory OnBoardingApi(Dio dio) = _OnBoardingApi;

  @POST(ApiStrings.saveCommonId)
  Future<HttpResponse> postCommonID(@Body() Map<String, dynamic> data);
}
