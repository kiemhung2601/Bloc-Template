import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/config/config.dart';
import '../../core/utils/log_utils.dart';
import 'api_service.dart';
import 'dio/dio_service.dart';
import 'dio/logging_interceptor.dart';
import 'dio/token_interceptor.dart';
import 'network_exception.dart';

///Base Respone
///{
///     "success":false,
///     "statusCode":4007,
///     "statusValue":"Message error",
///     "executeDate":"2023-12-01T03:01:02.304",
///     "data": JSON,
///     "token":null
/// }

class ApiServiceImpl implements ApiService {
  ApiServiceImpl({
    this.enableAuth = false,
    this.baseUrl = Config.baseUrl,
    this.timeout = Config.timeout,
  });

  final bool enableAuth;
  final String? baseUrl;
  final Duration timeout;

  DioService? _dioService;
  DioService get dioService => _dioService ??= DioService(
        BaseOptions(baseUrl: baseUrl ?? '', sendTimeout: timeout, connectTimeout: timeout, receiveTimeout: timeout),
        [
          if (enableAuth) TokenInterceptor(),
          if (Config.enableLogRequestInfo) LoggingInterceptor(),
        ],
      );

  Future<T> request<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,

    /// Custom
    required String method,
    required String contentType,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) async {
    try {
      final Response response = await dioService.request(
        path,
        data: data,
        options: Options(
          method: method,
          contentType: contentType,
          headers: <String, dynamic>{
            'requiresAuthToken': requiresAuthToken,
            'accept': 'application/json; charset=utf-8; text/plain; */*',
          },
        ),
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      if ((response.data as Map)['success'] == false) {
        //EXPIRED TOKEN
        if ((response.data as Map)['statusCode'] == 408) {
          throw const NetworkException.unauthorizedException();
        }

        throw NetworkException.apiException(
            statusCode: (response.data as Map)['statusCode'],
            message: (response.data as Map)['statusValue'],
            data: (response.data as Map)['data']);
      }

      //API SUCCESS
      if (converter != null) {
        return converter.call((response.data as Map)['data']);
      }

      return response.data as T;
    } catch (error) {
      throw _getException(error);
    }
  }

  @override
  void cancelRequests({CancelToken? cancelToken}) => dioService.cancelRequests(cancelToken: cancelToken);

  @override
  Future<T> deleteJson<T>(
    String path, {
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'DELETE',
        contentType: Headers.jsonContentType,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );

  @override
  Future<T> getJson<T>(
    String path, {
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'GET',
        contentType: Headers.jsonContentType,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );

  @override
  Future<T> putJson<T>(
    String path, {
    Object? data,
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'PUT',
        contentType: Headers.jsonContentType,
        data: data,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );

  @override
  Future<T> postJson<T>(
    String path, {
    required Object? data,
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'POST',
        contentType: Headers.jsonContentType,
        data: data,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );

  @override
  Future<T> postFormUrlEncoded<T>(
    String path, {
    required Object? data,
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'POST',
        contentType: Headers.formUrlEncodedContentType,
        data: data,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );

  @override
  Future<T> postFormData<T>(
    String path, {
    required FormData data,
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'POST',
        contentType: Headers.multipartFormDataContentType,
        data: data,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );

  @override
  Future<T> putFormUrlEncoded<T>(
    String path, {
    Object? data,
    Json? queryParameters,
    bool requiresAuthToken = true,
    Converter<T>? converter,
  }) =>
      request(
        path,
        method: 'PUT',
        contentType: Headers.formUrlEncodedContentType,
        data: data,
        queryParameters: queryParameters,
        requiresAuthToken: requiresAuthToken,
        converter: converter,
      );
}

NetworkException _getException(Object? error) {
  if (Config.enableLogNetworkException) {
    StackTrace? stackTrace;
    if (error is Error) {
      stackTrace = error.stackTrace;
    }
    Log.e('Error type: ${error.runtimeType}', name: 'NetworkException', errorObject: error, stackTrace: stackTrace);
  }

  return switch (error) {
    NetworkException() => error,
    SocketException() => const NetworkException.connectionException(),
    FormatException() || TypeError() => const NetworkException.formatException(),
    (final DioException error) => _getDioException(error),
    Object() || null => NetworkException.otherException(error.runtimeType),
  };
}

NetworkException _getDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionError:
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkException.connectionException();

    case DioExceptionType.badResponse:
      String? message;

      try {
        final json = error.response?.data as Map;

        message ??= json['Message'] as String?;
        message ??= json['message'] as String?;
      } catch (_) {
        message ??= error.message;
      }

      return NetworkException.apiException(statusCode: error.response?.statusCode, message: message);

    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      return _getException(error.error);
  }
}
