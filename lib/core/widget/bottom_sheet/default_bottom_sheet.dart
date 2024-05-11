import 'package:flutter/material.dart';

import '../../theme/theme.dart';

extension DefaultBottomSheetExtension on BuildContext {
  Future<int?> showOptionBottomSheet(Iterable<Widget> options, {int? indexSelected}) {
    return showModalDefaultBottomSheet(DefaultBottomSheet.option(options: options, indexSelected: indexSelected));
  }

  Future<T?> showModalDefaultBottomSheet<T>(
    DefaultBottomSheet bottomSheet, {
    bool useSafeArea = true,
    Color? barrierColor,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      elevation: 0,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimens.bottomSheetRadius,
        side: BorderSide(color: appColors.imageBackground, width: 0.25),
      ),
      builder: (BuildContext context) => bottomSheet,
    );
  }

  PersistentBottomSheetController<T> showDefaultBottomSheet<T>(DefaultBottomSheet bottomSheet) {
    return showBottomSheet<T>(
      context: this,
      elevation: 0,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimens.bottomSheetRadius,
        side: BorderSide(color: appColors.imageBackground, width: 0.25),
      ),
      builder: (BuildContext context) => bottomSheet,
    );
  }
}

class DefaultBottomSheet extends StatelessWidget {
  const DefaultBottomSheet({
    super.key,
    this.title,
    this.padding = const EdgeInsets.only(top: 16),
    this.heightFactor,
    this.resizeToAvoidBottomInset = true,
    required this.child,
  });

  DefaultBottomSheet.option({
    super.key,
    this.title,
    int? indexSelected,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
    this.heightFactor,
    this.resizeToAvoidBottomInset = true,
    double gap = AppDimens.bottomSheetGap,
    required Iterable<Widget> options,
  })  : padding = EdgeInsets.zero,
        child = DefaultTextStyle.merge(
          style: AppStyles.s18w400Roboto,
          child: Builder(builder: (BuildContext context) {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: padding.vertical).add(context.mediaQueryViewPadding),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () => Navigator.of(context).pop(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: padding.horizontal, vertical: gap / 2),
                  color: indexSelected == index ? context.colorScheme.primaryContainer : Colors.transparent,
                  child: options.elementAt(index),
                ),
              ),
            );
          }),
        );

  final String? title;
  final EdgeInsetsGeometry padding;
  final double? heightFactor;
  final bool resizeToAvoidBottomInset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final viewInsetHeight = resizeToAvoidBottomInset ? queryData.viewInsets.bottom + queryData.viewInsets.top : 0;
    final viewInsetWidth = queryData.viewInsets.left + queryData.viewInsets.right;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Build title
          Padding(
            padding: padding,
            child: title != null
                ? Text(title!, style: AppStyles.s18w700Roboto, overflow: TextOverflow.ellipsis, maxLines: 1)
                : null,
          ),

          /// Build body
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: (queryData.size.height * (heightFactor ?? 0.9)) - viewInsetHeight,
              maxWidth: queryData.size.width - viewInsetWidth,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
