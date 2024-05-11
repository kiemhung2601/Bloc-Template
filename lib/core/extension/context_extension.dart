import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/theme.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  AppThemeData get appTheme => AppThemeData.of(this);

  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);

  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  Orientation get mediaQueryOrientation => MediaQuery.orientationOf(this);

  /// similar to [Theme.of(context).colorScheme]
  ColorScheme get colorScheme => theme.colorScheme;

  /// similar to [Theme.of(context).textStyle]
  TextTheme get textStyle => theme.textTheme;

  /// similar to [AppThemeData.of(context).appColors]
  AppColors get appColors => appTheme.appColors;

  /// similar to [AppThemeData.of(context).themeMode]
  ThemeMode? get themeMode => appTheme.themeMode;

  /// similar to [AppThemeData.of(context).locale]
  Locale? get locale => appTheme.locale;

  /// Check if dark mode theme is enable
  bool get isDarkTheme {
    return themeMode == ThemeMode.dark || themeMode == ThemeMode.system && platformBrightness == Brightness.dark;
  }

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// check if device is on landscape mode
  bool get isLandscape => mediaQueryOrientation == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => mediaQueryOrientation == Orientation.portrait;

  /// True if the shortestSide is smaller than 600p
  bool get isPhone => mediaQueryShortestSide < 600;

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => mediaQueryShortestSide >= 600;

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => mediaQueryShortestSide >= 720;

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// Returns a specific value according to the screen size
  /// if the device width is higher than or equal to 1200 return
  /// [desktop] value. if the device width is higher than  or equal to 600
  /// and less than 1200 return [tablet] value.
  /// if the device width is less than 300  return [watch] value.
  /// in other cases return [mobile] value.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? watch,
  }) {
    final double deviceWidth = mediaQueryShortestSide;

    if (deviceWidth >= 1200 && desktop != null) {
      return desktop;
    } else if (deviceWidth >= 600 && tablet != null) {
      return tablet;
    } else if (deviceWidth < 300 && watch != null) {
      return watch;
    } else {
      return mobile;
    }
  }
}

extension WidgetExtension on Widget {
  SliverToBoxAdapter get toSliverBox => SliverToBoxAdapter(child: this);

  SliverPadding toSliverPadding(EdgeInsetsGeometry padding) => SliverPadding(
        padding: padding,
        sliver: toSliverBox,
      );
}
