import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../../../service_helper/api/api_strings.dart';

part 'permission_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class PermissionApi {
  factory PermissionApi(Dio dio) = _PermissionApi;

  @POST(ApiStrings.permissionData)
  Future<HttpResponse> postPermissionData(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.locationTracker)
  Future<HttpResponse> postLocation(@Body() Map<String, dynamic> data);

  @GET(ApiStrings.contactRefStatus)
  Future<HttpResponse> getContactRefStatus();

  @POST(ApiStrings.contactRef)
  Future<HttpResponse> postContactRef(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.language)
  Future<HttpResponse> postLanguage(@Body() Map<String, dynamic> data);
}
