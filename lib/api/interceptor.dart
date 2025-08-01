import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:logger/logger.dart';

import '../api/api_constant.dart';
import '../shared/services/token_storage.dart';

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

if (token != null) {
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
      final refreshToken = TokenStorage.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          log.w('Token expired. Trying to refresh...');

          final dio = Dio(); // dùng tạm để gọi refresh token
          final response = await dio.post(
            '${ApiConstant.baseUrl}${ApiConstant.refreshToken}',
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

          final retryDio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl))
            ..interceptors.add(AppInterceptors());

          final retryResponse = await retryDio.fetch(opts);

          return handler.resolve(retryResponse);
        } catch (e, stackTrace) {
          log.e('Refresh token failed! Clearing session.', error: e, stackTrace: stackTrace);
          await TokenStorage.clearAll();
          if (Get.context != null) {
            Get.offAllNamed('/login');
          }
        }
      } else {
        log.w('No refresh token found. Logging out.');
        await TokenStorage.clearAll();
        if (Get.context != null) {
          Get.offAllNamed('/login');
        }
      }
    }

    handler.next(err);
  }
}
