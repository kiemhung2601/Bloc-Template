import 'package:flutter/widgets.dart';

class AppParams {
  const AppParams._();

  static const Curve animationCurve = Curves.fastOutSlowIn;
  static const Duration animationDuration = Duration(milliseconds: 400);
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationLow = Duration(milliseconds: 800);

  static const Duration delayInputEnd = Duration(milliseconds: 1000);
}
