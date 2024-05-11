import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../theme/theme.dart';
import '../../widget/view/progress_indicator.dart';

class AppPagedChildBuilderDelegate<T> extends PagedChildBuilderDelegate<T> {
  AppPagedChildBuilderDelegate({
    required super.itemBuilder,

    /// Error
    super.firstPageErrorIndicatorBuilder = _pageErrorIndicator,
    super.newPageErrorIndicatorBuilder = _pageErrorIndicator,

    /// Progress
    super.firstPageProgressIndicatorBuilder = _pageProgressIndicator,
    super.newPageProgressIndicatorBuilder = _pageProgressIndicator,

    /// Other
    super.animateTransitions = true,
    super.noItemsFoundIndicatorBuilder,
    super.noMoreItemsIndicatorBuilder,
  });
}

Widget _pageErrorIndicator(BuildContext context) {
  final AppColors colors = context.appColors;
  final AppLocalizations l10n = context.l10n;

  return Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.refresh, color: colors.foreground),
      Text(l10n.somethingWentWrong, style: context.textStyle.bodySmall),
      const SizedBox(height: 8),
    ]),
  );
}

Widget _pageProgressIndicator(BuildContext context) {
  return const AppCircularProgressIndicator();
}
