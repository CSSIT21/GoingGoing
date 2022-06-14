import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../../constants/api_enpoints.dart';

class DioClient {
  static late Dio dio;

  static void init() {
    var options = BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      contentType: 'application/json',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    try {
      dio = Dio(options);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
