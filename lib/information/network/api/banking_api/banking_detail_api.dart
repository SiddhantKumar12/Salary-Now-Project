import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../../service_helper/api/api_strings.dart';

part 'banking_detail_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class BankingDetailApi {
  factory BankingDetailApi(Dio dio) = _BankingDetailApi;

  @GET(ApiStrings.bankDetails)
  Future<HttpResponse> getBankDetails();

  @PATCH(ApiStrings.updateBankDetails)
  Future<HttpResponse> updateBankDetails(@Body() Map<String, dynamic> data);
}
