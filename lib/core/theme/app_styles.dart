import 'package:flutter/material.dart';

class AppStyles {
  const AppStyles._();

  static double? textScaleFactor(BuildContext context, {double maxTextScaleFactor = 1}) {
    final double width = MediaQuery.of(context).size.width;
    if (width > 390) return null;

    return (width / 390).clamp(0.1, maxTextScaleFactor);
  }

  static const String fontRoboto = 'Roboto';
  static const String fontInter = 'Inter';
  static const Color displayColor = Colors.black;
  static const Color displayColorDark = Colors.white;

  /// Design config

  static const TextStyle s24w700Roboto = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s24w400Roboto = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s20w500Inter = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: AppStyles.fontInter,
  );

  static const TextStyle s20w700Roboto = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s20w400Roboto = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s18w700Roboto = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s18w400Roboto = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s16w400Roboto = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s16w700Roboto = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s14w700Roboto = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s14w400Roboto = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s13w700Roboto = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s13w400Roboto = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s12w400Roboto = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );

  static const TextStyle s10w400Roboto = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: AppStyles.fontRoboto,
  );
}
