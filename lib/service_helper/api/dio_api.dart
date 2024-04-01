import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:salarynow/storage/local_storage_strings.dart';
import '../../storage/local_storage.dart';
import '../../storage/local_user_modal.dart';

class DioApi {
  DioApi({this.isHeader = false});

  final bool isHeader;
  static LocalUserModal? localUserModal = MyStorage.getUserData();
  String? appId = MyStorage.readData(MyStorageString.uuid);

  static Map<String, dynamic>? header = {};

  final Dio _dio = Dio(BaseOptions(
      contentType: 'application/json',
      validateStatus: ((status) => true),
      sendTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120));

  Dio get sendRequest {
    if (isHeader) {
      header = {
        "user_id": localUserModal?.responseData?.userId,
        "token": localUserModal?.responseData?.id,
        "app_id": appId,
      };
    } else {
      header = null;
    }
    _dio.options.headers = header;
    return _dio;
  }
}
