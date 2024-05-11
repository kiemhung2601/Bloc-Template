import 'package:flutter/material.dart';

class AppColors {
  const AppColors.light(
      {this.primary = const Color(0xFF4C6EE0),
      this.background = const Color(0xFFFFFFFF),
      this.error = const Color(0xFFFF0000),
      this.foreground = const Color(0xFF000000),
      this.imageBackground = const Color(0xFFDCDCDC),
      this.divider = const Color(0xFFEEEEEE),
      this.dotMenu = const Color(0xFFC8C8C8),
      this.textBlack = const Color(0xFF333333),
      this.textGrey = const Color(0xFF797979),
      this.textDate = const Color(0xFF555555),
      this.textFieldUnderLine = const Color(0xFFE9E9E9),
      this.textFieldErrorText = const Color(0xFFFF6666),
      this.textFieldBackground = const Color(0xFFF6F9FC),
      this.textFieldBackgroundError = const Color(0xFFFFF8F8),
      this.textFieldBackgroundReadOnly = const Color(0xFFF6F6F6),
      this.textFieldHintText = const Color(0xFFCCCCCC),
      this.textFieldForgotPasswordUnderline = const Color(0xFF7B8FD2),
      this.buttonOulineBoderBlur = const Color(0xFFC0CDF5),
      this.buttonOulineBoder = const Color(0xFFE2E2E2),
      this.cameraBannerBackgroud = const Color(0xFFECECEC),
      this.cameraHintBox = const Color(0xFFD9D9D9),
      this.cameraHintText = const Color(0xFF808080),
      this.backgroundCard = const Color(0XFFB1B1B1),
      this.buttonGrey = const Color(0XFFB1B1B1),
      this.border = const Color(0xFF000000)});

  factory AppColors.dark() {
    return const AppColors.light(
      primary: Color(0xFFB6C4FF),
      background: Color(0xFF1B1B1F),
      foreground: Color(0xFFE4E1E6),
      divider: Color(0xFF90909A),
      textBlack: Color(0xFFC8C6CA),
      textGrey: Color(0xFFC8C6CA),
      textDate: Color(0xFFC8C6CA),
      textFieldBackground: Color(0xFF424659),
      textFieldBackgroundError: Color(0xFF93000A),
      textFieldBackgroundReadOnly: Color(0xFF1B1B1F),
      backgroundCard: Color(0xFFFFFFFF),
      border: Color(0xFF90909A),
    );
  }

  Color statusFromValue(num value) {
    if (value < 0) return error;

    return primary;
  }

  final Color primary;
  final Color background;
  final Color error;
  final Color foreground;
  final Color imageBackground;
  final Color divider;
  final Color dotMenu;
  final Color textBlack;
  final Color textGrey;
  final Color textDate;
  final Color textFieldUnderLine;
  final Color textFieldErrorText;
  final Color textFieldBackground;
  final Color textFieldBackgroundError;
  final Color textFieldBackgroundReadOnly;
  final Color textFieldHintText;
  final Color textFieldForgotPasswordUnderline;
  final Color buttonOulineBoderBlur;
  final Color buttonOulineBoder;
  final Color cameraBannerBackgroud;
  final Color cameraHintBox;
  final Color cameraHintText;
  final Color backgroundCard;
  final Color buttonGrey;
  final Color border;
}
