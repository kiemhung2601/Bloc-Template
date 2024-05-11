import 'package:flutter/foundation.dart';

abstract class Config {
  static const enableGeneralLog = kDebugMode;
  static const isPrettyJson = kDebugMode;
  static const flavor = String.fromEnvironment('FLAVOR');
  static bool get isDevFlavor => flavor.toLowerCase().contains('dev');

  /// network
  static const baseUrl = String.fromEnvironment('BASE_URL');
  static const timeout = Duration(seconds: 10);
  static const maxRetries = 1;

  /// bloc observer
  static const logOnBlocChange = false;
  static const logOnBlocCreate = false;
  static const logOnBlocClose = false;
  static const logOnBlocError = kDebugMode;
  static const logOnBlocEvent = kDebugMode;
  static const logOnBlocTransition = false;

  /// navigator observer
  static const enableErrorPage = kReleaseMode;
  static const enableNavigatorObserverLog = kDebugMode;

  /// log interceptor
  static const enableLogNetworkException = kDebugMode;
  static const enableLogRequestInfo = kDebugMode;

  /// Kakao Talk
  static const kakaoEnableLog = kDebugMode;
  static const kaKaoAppKey = String.fromEnvironment('KAKAO_TALK_APP_KEY');
  static const kaKaoTemplateId = int.fromEnvironment('KAKAO_TALK_TEMPLATE_ID');

  /// Deep link
  static const deepLinkUrl = String.fromEnvironment('DEEP_LINK_URL');
}
