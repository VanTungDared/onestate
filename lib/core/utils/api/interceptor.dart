import 'package:dio/dio.dart';
import 'package:get/get.dart' as dio;
import 'package:logger/logger.dart';

import '../../../data/datasources/dblocal/shared_preferences.dart';
import '../../../presentation/routers/routerName.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d(
      'Error type: ${err.error} \n '
      'Error message: ${err.message}',
    ); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); //Info log
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${response.data}',
    ); // Debug log
    handler.next(response); // continue with the Response
  }
}

class AuthorizationInterceptor extends Interceptor {
  final Dio _dio;

  AuthorizationInterceptor(this._dio);

  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const excludedPaths = ['/auth/login'];

    if (excludedPaths.any((path) => options.path.contains(path))) {
      return handler.next(options);
    }

    final token = SharedPreferenceApp.handleGetString('accessToken');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 &&
        err.response?.data['message'] == 'Token expired') {
      SharedPreferenceApp.handleClear();

      if (dio.Get.currentRoute != RouterName.login) {
        dio.Get.offAllNamed(RouterName.login);
      }

      logger.w("Token expired. Redirecting to login.");
    }

    handler.next(err);
  }
}
