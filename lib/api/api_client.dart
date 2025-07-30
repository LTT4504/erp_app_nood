// api/api_client.dart

import 'package:dio/dio.dart';
import 'api_constant.dart';
import 'interceptor.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  )..interceptors.add(AppInterceptors());
}
