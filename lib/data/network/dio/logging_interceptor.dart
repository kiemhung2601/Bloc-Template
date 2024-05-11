import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/utils/log_utils.dart';
import '../api_service.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String httpMethod = options.method;

    _printHeader(title: httpMethod, text: options.uri.toString());

    _printBody('Headers:');
    options.headers.forEach((String k, Object? v) => _printBody('\t$k: $v'));

    if (options.queryParameters.isNotEmpty) {
      _printBody('QueryParameters:');
      options.queryParameters.forEach((String k, dynamic v) => _printBody('\t$k: $v'));
    }

    if (options.data is Json) {
      _printBody('Body:');
      _printBody('\t${_getBody(options.data)}');
    }

    _printFooter(title: httpMethod);

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final RequestOptions options = response.requestOptions;
    final String httpMethod = options.method;

    _printHeader(
      title: '$httpMethod ❱➤ ${response.statusCode} ${response.statusMessage}',
      text: options.uri.toString(),
      type: 1,
    );

    if (response.data is Json || response.data is Iterable) {
      _printBody('Response:', type: 1);
      _printBody('\t${_getBody(response.data)}', type: 1);
    }
    _printFooter(title: httpMethod, type: 1);

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final RequestOptions options = err.requestOptions;
    final String httpMethod = options.method;

    _printHeader(
      title: '$httpMethod ❱➤ ${err.response?.statusCode} ${err.response?.statusMessage}',
      text: options.uri.toString(),
      type: 2,
    );

    if (err.response?.data is Json || err.response?.data is Iterable) {
      _printBody('Response:', type: 2);

      _logPrint(Log.prettyJson(err.response?.data), type: 2);
    }

    _printFooter(title: httpMethod, type: 2);

    try {
      _logPrint(cURLRepresentation(err.requestOptions), type: 3);
    } catch (err) {
      _logPrint('Unable to create a CURL representation of the errored', type: 3);
    }

    return super.onError(err, handler);
  }
}

void _logPrint(String message, {int type = 0}) {
  switch (type) {
    case 0:
      Log.log('\x1B[33m$message', name: 'Dio');

    case 1:
      Log.log('\x1B[32m$message', name: 'Dio');

    case 2:
      Log.log('\x1B[31m$message', name: 'Dio');

    default:
      Log.log(message, name: 'Dio');
  }
}

void _printHeader({String? title, String? text, int type = 0}) {
  _logPrint('╔╣ $title', type: type);
  _logPrint('║ $text', type: type);
}

void _printBody(String? content, {int type = 0}) {
  _logPrint('║ $content', type: type);
}

void _printFooter({String? title, int type = 0}) {
  _logPrint('╚═ END $title', type: type);
}

String? _getBody(dynamic data) {
  try {
    return jsonEncode(data);
  } catch (_) {
    return data.toString();
  }
}

String cURLRepresentation(RequestOptions request) {
  final List<String> components = <String>[];
  components.add("curl --request ${request.method.toUpperCase()} '${request.uri}'");
  // Header
  request.headers.forEach((String k, dynamic v) {
    if (!k.contains('content-length')) {
      components.add("--header '$k: $v'");
    }
  });

  // Body
  if (request.contentType?.contains(Headers.formUrlEncodedContentType) ?? false) {
    final Json json = request.data as Json;
    for (final MapEntry<String, dynamic> value in json.entries) {
      components.add("--data-urlencode '${value.key}=${value.value}'");
    }
  } else if (request.contentType?.contains(Headers.multipartFormDataContentType) ?? false) {
    final FormData formData = request.data as FormData;
    for (final MapEntry<String, String> value in formData.fields) {
      components.add("--form '${value.key}=\"${value.value}\"'");
    }
    for (final MapEntry<String, MultipartFile> e in formData.files) {
      components.add("--form '${e.key}=\"@/path/${e.value.filename}\"'");
    }
  } else if (request.data != null) {
    components.add("--data '${_getBody(request.data)}'");
  }

  return components.join(' \\\n');
}
