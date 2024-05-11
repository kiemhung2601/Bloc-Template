import 'package:freezed_annotation/freezed_annotation.dart';

import 'paging_constants.dart';

part 'app_pagination.freezed.dart';

@freezed
class AppPagination<T> with _$AppPagination<T> {
  const factory AppPagination({
    required List<T> data,
    required int pageNumber,
    @Default(PagingConstants.itemsPerPage) int pageSize,
    @Default(0) int totalElements,
  }) = _AppPagination;

  const AppPagination._();

  int get nextPageNumber => pageNumber + 1;
  int get previousPageNumber => pageNumber - 1;

  bool get first => pageNumber == 0;
  bool get last => (pageNumber * pageSize) >= totalElements;
}
