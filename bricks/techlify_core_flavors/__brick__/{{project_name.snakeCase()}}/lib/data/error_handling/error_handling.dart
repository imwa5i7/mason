import 'dart:async';
import 'dart:io';
import 'package:togo_mobile/data/service/data.service.dart';
import 'api_response.dart';

class ErrorHandling {
  static ApiResponse returnException(Object exception, {String? localDataKey, bool loadOfflineData = false}) {
    if (exception is SocketException) {
      return ApiResponse.noInternet('No Internet');
    } else if (exception is TimeoutException) {
      return ApiResponse.timeout('Timeout');
    } else if (exception is UnauthorisedException) {
      return ApiResponse.unAuthorised('Unauthorized');
    } else {
      return ApiResponse.error('Some Error Occured');
    }
  }
}
