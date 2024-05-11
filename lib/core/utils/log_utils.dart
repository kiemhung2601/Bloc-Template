import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import '../config/config.dart';

class Log {
  const Log._();

  static const _enableLog = Config.enableGeneralLog;

  static void d(
    Object? message, {
    String? name,
    DateTime? time,
  }) {
    log('💡 $message', name: name ?? '', time: time);
  }

  static void e(
    Object? errorMessage, {
    String? name,
    Object? errorObject,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    log(
      '💢 $errorMessage',
      name: name ?? '',
      error: errorObject,
      stackTrace: stackTrace,
      time: time,
    );
  }

  static String prettyJson(Object json) {
    if (!Config.isPrettyJson) {
      return json.toString();
    }

    const encoder = JsonEncoder.withIndent('\t');

    return encoder.convert(json);
  }

  static void log(
    String message, {
    int level = 0,
    String name = '',
    DateTime? time,
    int? sequenceNumber,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enableLog) {
      dev.log(
        message,
        name: name,
        time: time,
        sequenceNumber: sequenceNumber,
        level: level,
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
