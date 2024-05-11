import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkException with _$NetworkException implements Exception {
  const NetworkException._() : super();

  const factory NetworkException.unauthorizedException() = _UnauthorizedException;

  const factory NetworkException.otherException(Type type) = _OtherException;

  const factory NetworkException.formatException() = _FormatException;

  const factory NetworkException.connectionException() = _ConnectionException;

  const factory NetworkException.maintenanceException() = _MaintenanceException;

  const factory NetworkException.apiException({
    int? statusCode,
    String? message,
    Object? data,
  }) = _ApiException;

  int? get statusCode => whenOrNull(apiException: (statusCode, _, __) => statusCode);

  String? get message => maybeWhen<String?>(
        apiException: (_, message, __) => message,
        formatException: () => 'Chức năng đã thay đổi',
        connectionException: () => 'Kết nối bị gián đoạn. Xin hãy thử lại sau',
        orElse: () => 'Đã xảy ra lỗi. Xin hãy thử lại sau',
      );
}
