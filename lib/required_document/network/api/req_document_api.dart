import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../../../../service_helper/api/api_strings.dart';

part 'req_document_api.g.dart';

@RestApi(baseUrl: ApiStrings.baseUrl)
abstract class ReqDocumentApi {
  factory ReqDocumentApi(Dio dio) = _ReqDocumentApi;

  @POST(ApiStrings.document)
  Future<HttpResponse> postAadhaarCard(@Body() Map<String, dynamic> data);

  @POST(ApiStrings.uploadStatementType)
  Future<HttpResponse> uploadStatement(@Body() Object object);

  @POST(ApiStrings.uploadSelfie)
  Future<HttpResponse> uploadSelfie(@Body() Object object);

  @POST(ApiStrings.getDocument)
  Future<HttpResponse> getDocument(@Body() Map<String, dynamic> data);

  @GET(ApiStrings.bankStatementDate)
  Future<HttpResponse> getBankStatementDate();
}
