import 'package:flutter/widgets.dart';

import '../utils/string_utils.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}

extension StringExtension on String? {
  /// Remove Leading and Trailing Spaces and remove Duplicate Spaces
  String? trimExtra() => this?.trim().replaceAll(RegExp(r'\s+'), ' ');

  int compareASC(String? text, {bool caseSensitive = false}) {
    if (caseSensitive) {
      return this?.compareTo(text ?? '') ?? 0;
    }
    return this?.toLowerCase().compareTo(text?.toLowerCase() ?? '') ?? 0;
  }

  int compareDESC(String? text, {bool caseSensitive = false}) {
    return -compareASC(text, caseSensitive: caseSensitive);
  }

  String get toPhoneString => StringUtils.phoneFormatString(this ?? '');
}
