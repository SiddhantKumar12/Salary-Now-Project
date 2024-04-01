import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../../service_helper/api/api_strings.dart';

part 'emp_detail_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class EmpDetailApi {
  factory EmpDetailApi(Dio dio) = _EmpDetailApi;

  @GET(ApiStrings.employmentDetails)
  Future<HttpResponse> getEmpDetails();

  @PATCH(ApiStrings.updateEmploymentDetails)
  Future<HttpResponse> updateEmpDetails(@Body() Map<String, dynamic> data);
}
