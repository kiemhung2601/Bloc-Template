import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_menu.freezed.dart';
part 'home_menu.g.dart';

@freezed
class HomeMenu with _$HomeMenu {
  const factory HomeMenu({
    @Default('') String icon,
    @Default('') String title,
  }) = _HomeMenu;

  // To JSON
  const HomeMenu._();

  // From JSON
  factory HomeMenu.fromJson(Map<String, dynamic> json) => _$HomeMenuFromJson(json);
}
