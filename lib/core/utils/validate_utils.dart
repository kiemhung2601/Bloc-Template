import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:intl/intl.dart';

class ValidateUtils {
  const ValidateUtils._();

  static late AppLocalizations l10n;

  static final RegExp regExpPassword = RegExp(r'^[a-zA-Z0-9 ~`!@#$%^&*()-_=+]{6,32}');

  static final RegExp regExpEmail = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static final RegExp dateTextKo = RegExp(r'([0-9]{4}|[0-9]{2})(년)?\s?(0[1-9]|1[0-2])(월)\s?([0-2][0-9]|3[0-1])?(일)?');
  static final RegExp password = RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)');
  static final RegExp email = RegExp(r'^(([\w-\.]+@([\w-]+\.)+[\w-]{2,4}))$');
  static final RegExp phoneMobile = RegExp(r'^\d{3}-?\d{4}-?\d{4}$');
  static final RegExp dateDMY =
      RegExp(r'([0-2][0-9]|3[0-1])?(\\|\/|\-|\.|\,|\s)?(0[1-9]|1[0-2])(\\|\/|\-|\.|\,|\s)([0-9]{4}|[0-9]{2})');
  static final RegExp dateYMD = RegExp(
      r'([0-9]{4}|[0-9]{2})(\\|\/|\-|\.|\,|년|\s)\s?(0?[1-9]|1[0-2])(\\|\/|\-|\.|\,|월|\s)\s?([1-2][0-9]|0?[1-9]|3[0-1])?');
  static final RegExp date = RegExp('${dateDMY.pattern}|${dateYMD.pattern}');
  static final RegExp prices =
      RegExp(r'(^(\d{1,3}[.,])+(\d{1,3})$|[₩wW]\s?(\d{1,3}[.,])*(\d{1,3})|(\d{1,3}[.,])*(\d{1,3})\s?[원])');
  static final RegExp place = RegExp(r'^(?!교환처)([^\d+\s]+)');

  // static String? validStandard(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.textEntry;
  //   }
  //   return null;
  // }

  // static String? validUnitOfPurchase(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.enterNumber;
  //   }
  //   return null;
  // }

  // static String? validBusinessNumber(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.enterYourBusinessNumber;
  //   }
  //   return null;
  // }

  // static String? validBusinessName(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.enterBusinessName;
  //   }
  //   return null;
  // }

  // static String? validAccountCode(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.enterAccountCode;
  //   }
  //   return null;
  // }

  // static String? validBusinessClassification(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.plsSelectBusinessType;
  //   }
  //   return null;
  // }

  // static String? validIdentity(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.existId;
  //   } else if (value.length < 5 || value.length > 20) {
  //     return l10n.idMustBeFrom5To20Characters;
  //   }
  //   return null;
  // }

  // static String? validPassword(String? value) {
  //   // if (value == null || value.trim().isEmpty) {
  //   //   return l10n.plsInputYourPassword;
  //   // } else
  //   if (!password.hasMatch(value ?? '')) {
  //     return l10n.plsEnterCorrectPasswordFormat;
  //   }
  //   return null;
  // }

  // static String? validRePassword(String? value, String oldPass) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.passwordDoNotMatch;
  //   } else if (value != oldPass) {
  //     return l10n.passwordDoNotMatch;
  //   }
  //   return null;
  // }

  // static String? validNickname(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.plsEnterAtLeastOneCharacter;
  //   } else if (value.length < 3 || value.length > 20) {
  //     return l10n.correctNickname;
  //   }
  //   return null;
  // }

  // static String? validEmail(String? value) {
  //   if (value == null || !email.hasMatch(value)) {
  //     return l10n.invalidFormat;
  //   }
  //   return null;
  // }

  // static String? validPhoneNumber(String? value) {
  //   if (!phoneMobile.hasMatch(value ?? '')) {
  //     return l10n.invalidFormat;
  //   }
  //   return null;
  // }

  // static String? validRegisterationPath(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.plsEnterTheSubscriptionPath;
  //   }
  //   return null;
  // }

  // static String? validOtp(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return l10n.authenticationInformationIncorrect;
  //   }
  //   return null;
  // }

  // static bool isDate(String? input) {
  //   try {
  //     DateFormat('yyyy-MM-dd').parseStrict(input ?? '');
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // static String? validateInputData(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return l10n.plsInputData;
  //   }
  //   return null;
  // }
}
