import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

import '../api/api_constant.dart';
import '../shared/services/token_storage.dart';

// Logger setup
final log = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.none,

  ),
);

class AppInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    log.i('REQUEST [${options.method}] => PATH: ${options.uri}');
    log.d('Headers: ${options.headers}');
    log.d('Data: ${options.data}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i(
        'RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.uri}');
    log.d('Response: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;

    log.e('ERROR [$statusCode] => PATH: ${requestOptions.uri}',
        error: err, stackTrace: err.stackTrace);

    if (statusCode == 401 && !requestOptions.extra.containsKey("retry")) {
      final refreshToken = await TokenStorage.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          log.w('Token expired. Trying to refresh...');

          final dio = Dio(); // temp Dio for refresh
          final response = await dio.post(
            ApiConstant.refreshToken,
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          await TokenStorage.saveAccessToken(newAccessToken);
          await TokenStorage.saveRefreshToken(newRefreshToken);

          // Retry original request
          final opts = requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken';
          opts.extra['retry'] = true;

          final retryDio = Dio()..interceptors.add(this);
          final retryResponse = await retryDio.fetch(opts);

          return handler.resolve(retryResponse);
        } catch (e) {
          log.e('Refresh token failed! Clearing session.');
          await TokenStorage.clearAll();

          Get.offAllNamed('/login');
        }
      } else {
        log.w('No refresh token found. Logging out.');
        await TokenStorage.clearAll();
        Get.offAllNamed('/login');
      }
    }

    handler.next(err);
  }
}
