import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:erp_app_nood/shared/services/token_storage.dart';

// Khởi tạo logger
final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = TokenStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    log.i('➡️ REQUEST [${options.method}] => PATH: ${options.uri}');
    log.d('Headers: ${options.headers}');
    log.d('Data: ${options.data}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('✅ RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.uri}');
    log.d('Response: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.e('❌ ERROR [${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}',
        error: err, stackTrace: err.stackTrace);
    handler.next(err);
  }
}
