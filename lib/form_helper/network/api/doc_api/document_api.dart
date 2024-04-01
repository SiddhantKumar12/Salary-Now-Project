import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../service_helper/api/api_strings.dart';

part 'document_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class DocumentApi {
  factory DocumentApi(Dio dio) = _DocumentApi;

  @GET(ApiStrings.getDocAddType)
  Future<HttpResponse> getDocAddType();

  @GET(ApiStrings.getAccomodationType)
  Future<HttpResponse> getAccomodationType();
}
