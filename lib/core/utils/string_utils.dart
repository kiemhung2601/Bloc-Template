import 'package:intl/intl.dart';

import '../extension/num_extension.dart';

class StringUtils {
  StringUtils._();

  static const needleRegex = r'{#}';
  static const needle = '{#}';
  static final RegExp exp = RegExp(needleRegex);

  static String interpolate(String string, List l) {
    final Iterable<RegExpMatch> matches = exp.allMatches(string);

    assert(l.length == matches.length);

    var i = -1;
    return string.replaceAllMapped(exp, (match) {
      i = i + 1;
      return '${l[i]}';
    });
  }

  static String toCurrencyFormat(num money) {
    final oCcy = NumberFormat('#,###');
    return '${oCcy.format(money)}원';
  }

  static String formatThousands(num number) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(number);
  }

  static String formatPercent(num number, [int surplus = 2]) {
    String value = '';
    if (number.isInt) {
      value = number.toInt().toString();
      return value;
    } else {
      value = number.toStringAsFixed(surplus);
      final double checkValue = double.parse(value);
      if (checkValue.isInt) {
        value = checkValue.toInt().toString();
        return value;
      } else {
        return value;
      }
    }
  }

  static String phoneFormatString(String phoneNumber) {
    if (phoneNumber.length > 6) {
      return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6, phoneNumber.length)}';
    }
    return phoneNumber;
  }

  static String customStripHtmlIfNeeded(String text) {
    // The regular expression is simplified for an HTML tag (opening or
    // closing) or an HTML escape. We might want to skip over such expressions
    // when estimating the text directionality.
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  static String convertHtmlToString(String text) {
    final cutFristSpace = text.replaceFirst(RegExp(r'\s+'), ' ');
    final str = customStripHtmlIfNeeded(cutFristSpace);
    return str;
  }

  static bool isURL(String value) {
    final reg = RegExp(r'^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://).+');
    return reg.hasMatch(value);
  }
}
