import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/theme.dart';

extension DefaultDialogExt on BuildContext {
  Future<T?> showDefaultDialog<T>(
    DefaultDialog dialog, {
    bool useRootNavigator = true,
    bool closeOnTapOutside = true,
  }) =>
      showDialog(
        context: this,
        useRootNavigator: useRootNavigator,
        barrierDismissible: closeOnTapOutside,
        builder: (BuildContext context) => dialog,
      );

  Future<int?> showOptionDialog(Iterable<Widget> options, {bool useRootNavigator = true}) => showDialog(
        context: this,
        useRootNavigator: useRootNavigator,
        builder: (BuildContext context) => DefaultDialog.option(options: options),
      );
}

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({
    super.key,
    this.alignment = Alignment.center,
    this.dialogWidth = AppDimens.dialogWidth,
    this.padding = AppDimens.dialogPadding,
    this.dialogPadding = AppDimens.dialogPadding,
    this.radius = AppDimens.dialogRadius,
    this.iconClose = false,
    required this.child,
  });

  DefaultDialog.common({
    super.key,
    this.iconClose = false,
    this.alignment = Alignment.center,
    this.dialogWidth = AppDimens.dialogWidth,
    this.padding = AppDimens.dialogPadding,
    this.dialogPadding = AppDimens.dialogPadding,
    this.radius = AppDimens.dialogRadius,
    double gap = AppDimens.dialogGap,
    Widget? image,
    Widget? title,
    Widget? content,
    Widget? action,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  })  : assert(title != null || content != null),
        child = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            if (image != null) ...<Widget>[Center(child: image), SizedBox(height: gap)],
            if (title != null)
              DefaultTextStyle.merge(
                style: AppStyles.s20w700Roboto,
                textAlign: TextAlign.center,
                child: title,
              ),
            if (title != null && content != null) SizedBox(height: gap),
            if (content != null)
              DefaultTextStyle.merge(
                style: AppStyles.s14w400Roboto,
                textAlign: TextAlign.center,
                child: content,
              ),
            if (action != null) ...[SizedBox(height: gap), action]
          ],
        );

  DefaultDialog.option({
    super.key,
    this.iconClose = false,
    this.alignment = Alignment.center,
    this.dialogWidth = AppDimens.dialogWidth,
    this.padding = AppDimens.dialogPadding,
    this.dialogPadding = AppDimens.dialogPadding,
    this.radius = AppDimens.dialogRadius,
    double gap = AppDimens.dialogGap,
    required Iterable<Widget> options,
  }) : child = DefaultTextStyle.merge(
          style: AppStyles.s24w400Roboto,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: options.length,
            separatorBuilder: (context, index) => SizedBox(height: gap),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => Navigator.of(context).pop(index),
              child: options.elementAt(index),
            ),
          ),
        );

  final Alignment? alignment;
  final double? dialogWidth;
  final EdgeInsets? padding;
  final EdgeInsets? dialogPadding;
  final BorderRadius radius;
  final bool iconClose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return Dialog(
      elevation: 0,
      alignment: alignment,
      insetPadding: dialogPadding,
      shape: RoundedRectangleBorder(borderRadius: radius),
      backgroundColor: colors.background,
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          children: [
            Container(
              width: dialogWidth,
              padding: padding,
              child: child,
            ),
            if (iconClose)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                    icon: Icon(Icons.close, size: 30, color: context.appColors.foreground),
                    onPressed: () => Navigator.of(context).pop()),
              )
          ],
        ),
      ),
    );
  }
}
