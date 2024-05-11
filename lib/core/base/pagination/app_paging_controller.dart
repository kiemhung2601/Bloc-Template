import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'app_pagination.dart';
import 'paging_constants.dart';

class AppPagingController<T> extends PagingController<int, T> {
  AppPagingController({
    super.firstPageKey = PagingConstants.initialPage,
    super.invisibleItemsThreshold = PagingConstants.defaultInvisibleItemsThreshold,
  });

  Future<void> fetchPage(Future<AppPagination<T>> onLoadMore) async {
    try {
      final pagination = await onLoadMore;

      onSuccess(pagination);
    } catch (e) {
      onError(e);
    }
  }

  /// call [trigger] when initState
  void trigger({
    final PageRequestListener<int>? onLoadMore,
    final PagingStatusListener? onStatusChange,
  }) {
    if (onLoadMore != null) addPageRequestListener(onLoadMore.call);

    if (onStatusChange != null) addStatusListener(onStatusChange.call);
  }

  /// call [onSuccess] when success
  void onSuccess(AppPagination<T> pagination) {
    if (pagination.last) {
      appendLastPage(pagination.data);
    } else {
      appendPage(pagination.data, pagination.nextPageNumber);
    }
  }

  /// call [onError] when error
  void onError(Object? exception) {
    if (exception is Error || exception is Exception) error = exception;
  }

  /// call [onError] when error
  Future<void> onRefresh() async => refresh();
}
