import 'package:dio/dio.dart';

import '../../../shared/token_provider.dart';

class AuthInterceptor extends Interceptor {
  final AuthTokenProvider tokenProvider;

  AuthInterceptor(this.tokenProvider);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenProvider.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Optional: handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      // e.g., trigger logout, refresh token, etc.
    }

    return handler.next(err);
  }
}
