import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

mixin ThemeMixin<T extends StatefulWidget> on State<T> {
  late AppLocalizations l10n;
  late ColorScheme colorScheme;
  late AppThemeData appThemes;
  late TextTheme textStyle;
  late bool isDarkTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    l10n = context.l10n;
    colorScheme = context.colorScheme;
    appThemes = context.appTheme;
    textStyle = context.textStyle;
    isDarkTheme = context.isDarkTheme;
    ValidateUtils.l10n = l10n;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
