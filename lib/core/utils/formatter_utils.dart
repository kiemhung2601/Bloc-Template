import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  const DateTimeFormatter._();

  // Convert
  static final dateTimeConvert = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

  static final dateConvert = DateFormat('yyyy-MM-dd');

  // Format
  static final dateTimeFormatSlash = DateFormat('yyyy/MM/dd HH:mm:ss');

  static final dateFormatSlash = DateFormat('yyyy/MM/dd');

  static final dateTimeFormatHyphen = DateFormat('yyyy-MM-dd HH:mm:ss');

  static final dateFormatHyphen = DateFormat('yyyy-MM-dd');

  static final dateTimeFormatDot = DateFormat('yyyy.MM.dd HH:mm:ss');

  static final dateFormatDot = DateFormat('yyyy.MM.dd');

  static final timeFormat = DateFormat('HH:mm:ss');

  static final timeNoSecondFormat = DateFormat('HH:mm');
}

class DateTextFormatter extends TextInputFormatter {
  const DateTextFormatter({this.seperator = '-'});

  final String seperator;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _format(newValue.text, seperator);
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    String newString = '';

    for (int i = 0; i < math.min(value.length, 8); i++) {
      newString += value[i];
      if ((i == 3 || i == 5) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class TimeTextFormatter extends TextInputFormatter {
  const TimeTextFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _format(newValue.text, ':');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    String newString = '';

    for (int i = 0; i < math.min(value.length, 4); i++) {
      newString += value[i];
      if ((i == 1) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class PhoneNumberTextFormatter extends TextInputFormatter {
  const PhoneNumberTextFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = _format(newValue.text, '-');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    String newString = '';

    for (int i = 0; i < math.min(value.length, 13); i++) {
      newString += value[i];
      if ((i == 2 || i == 6) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class ThousandFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final int num = int.parse(newValue.text.replaceAll(',', ''));
    final f = NumberFormat('#,###');
    final String formatted = f.format(num);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
