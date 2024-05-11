import 'package:dio/dio.dart';

import '../../../core/config/injector.dart';
import '../../provider/auth_provider.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor() : super();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('requiresAuthToken')) {
      if (options.headers['requiresAuthToken'] == true) {
        final String? token = await getIt.get<AuthProvider>().getAuthToken();
        options.headers.addAll(<String, Object?>{'Authorization': token});
      }

      options.headers.remove('requiresAuthToken');
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if ((response.data as Map?)?['statusCode'] == 408) {
        getIt.get<AuthProvider>().logout();
      }
      if ((response.data as Map?)?['token'] is String) {
        getIt.get<AuthProvider>().saveToken((response.data as Map?)?['token']);
      }
    } catch (_) {}
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      await getIt.get<AuthProvider>().logout();
    }

    super.onError(err, handler);
  }
}
