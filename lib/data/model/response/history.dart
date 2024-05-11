import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/converter_utils.dart';

part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class History with _$History {
  const factory History({
    @Default('') String title,
    @Default('') String description,
    @ConvertStringToDateTime() DateTime? dateHis,
  }) = _History;

  // To JSON
  const History._();

  // From JSON
  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}
