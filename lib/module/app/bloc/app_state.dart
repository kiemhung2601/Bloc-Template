part of 'app_bloc.dart';

@freezed
class AppState extends HiveObject with _$AppState {
  @HiveType(typeId: 1, adapterName: 'AppStateAdapter')
  factory AppState({
    @Default(1) @HiveField(0, defaultValue: 1) int themeModeIndex,
    @Default('vi') @HiveField(1, defaultValue: 'vi') String languageCode,
  }) = _AppState;

  AppState._();

  ThemeMode get themeMode => ThemeMode.values.elementAt(themeModeIndex);

  Locale get locale => Locale(languageCode);

  static String themeModeText(ThemeMode mode) => switch (mode) {
        ThemeMode.system => ValidateUtils.l10n.system,
        ThemeMode.light => ValidateUtils.l10n.light,
        ThemeMode.dark => ValidateUtils.l10n.dark,
      };

  static IconData themeModeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.system => Icons.auto_mode,
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
      };

  static String localeText(Locale locale) => switch (locale) {
        (final Locale locale) when locale.languageCode == 'vi' => ValidateUtils.l10n.vietnamese,
        Locale() => ValidateUtils.l10n.english,
      };

  // static String localeImage(Locale locale) => switch (locale) {
  //       (final Locale locale) when locale.languageCode == 'ko' => AppImages.korean,
  //       (final Locale locale) when locale.languageCode == 'ja' => AppImages.japan,
  //       (final Locale locale) when locale.languageCode == 'zh' => AppImages.china,
  //       Locale() => AppImages.english,
  //     };
}
