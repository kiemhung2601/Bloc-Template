part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.changeThemeMode(ThemeMode themeMode) = _ChangeThemeMode;

  const factory AppEvent.changeLocale(Locale locale) = _ChangeLocale;

  const AppEvent._();
}
