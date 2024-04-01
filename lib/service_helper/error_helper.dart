import 'dart:io';

import 'package:dio/dio.dart';
import 'package:salarynow/utils/written_text.dart';

String handleDioError(DioError error) {
  if (error.error is SocketException) {
    return MyWrittenText.noInternet;
  }
  switch (error.type) {
    case DioErrorType.cancel:
      return 'Request was cancelled';
    case DioErrorType.connectionTimeout:
      return 'Connection timeout occurred';
    case DioErrorType.sendTimeout:
      return 'Request timed out while sending data';
    case DioErrorType.receiveTimeout:
      return 'Request timed out while receiving data';
    case DioErrorType.unknown:
      return 'Unknown Error';
    case DioErrorType.badCertificate:
      return 'Invalid Certificate';
    case DioErrorType.connectionError:
      return 'Connection Error';
  }
  return 'Something Error Wrong';

  // // Check if there was no internet connection
  // if (error is SocketException) {
  //   // Handle no internet connection here
  // }
}
