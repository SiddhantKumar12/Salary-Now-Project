import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../service_helper/api/api_strings.dart';

part 'packages_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class PackagesApi {
  factory PackagesApi(Dio dio) = _PackagesApi;

  @GET(ApiStrings.packages)
  Future<HttpResponse> getPackages();

  @POST(ApiStrings.loanCalculator)
  Future<HttpResponse> postLoanCalculator(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.applyLoan)
  Future<HttpResponse> postApplyLoan(@Body() Map<String, dynamic> data);
}
