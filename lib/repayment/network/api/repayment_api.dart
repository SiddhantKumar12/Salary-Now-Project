import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../service_helper/api/api_strings.dart';

part 'repayment_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class RepaymentApi {
  factory RepaymentApi(Dio dio) = _RepaymentApi;

  // @POST(ApiStrings.repaymentLoan)
  // Future<HttpResponse> postRepayment(@Body() Map<String, dynamic> data);

  @GET(ApiStrings.previousLoan)
  Future<HttpResponse> getPreviousLoan();

  @GET(ApiStrings.loanCharges)
  Future<HttpResponse> getLoanCharges();

  @GET(ApiStrings.getLedger)
  Future<HttpResponse> getLedger();
}
