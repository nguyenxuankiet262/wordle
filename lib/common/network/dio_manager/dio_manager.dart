import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioManager {
  Dio dio = Dio();

  DioManager() {
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
    }
  }
}
