part of 'history_bloc.dart';

@freezed
class HistoryState with _$HistoryState {
  factory HistoryState({
    @Default(AppPagination<History>(data: <History>[], pageNumber: 0)) AppPagination<History> items,
    @Default(false) bool isShimmerLoading,
  }) = _HistoryState;
}
