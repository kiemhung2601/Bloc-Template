import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../view/progress_indicator.dart';

class AppTextIconButton extends StatelessWidget {
  const AppTextIconButton({
    super.key,
    this.gap = 4,
    this.reversed = false,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.padding = AppDimens.buttonPadding,
    this.primary,
    this.expandedWith = true,
    this.isLoading = false,
    this.alignment,
    this.height = AppDimens.buttonHeight,
    this.width = 0.0,
    this.borderRadius = AppDimens.buttonRadius,
  });

  final double gap;

  final bool reversed;

  final Widget icon;

  final Widget label;

  final Color? primary;

  final EdgeInsetsGeometry padding;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onHover;

  final ValueChanged<bool>? onFocusChange;

  final bool expandedWith;

  final AlignmentGeometry? alignment;

  final bool isLoading;

  final double height;

  final double width;

  final BorderRadiusGeometry borderRadius;

  bool get isDisable => onPressed == null;

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor = primary ?? context.colorScheme.primary;
    final Color? disabledForegroundColor = primary?.withOpacity(0.2);

    List<Widget> items = <Widget>[
      AnimatedSize(
        duration: AppParams.animationDurationFast,
        curve: Curves.fastOutSlowIn,
        child: isLoading
            ? SizedBox(
                height: height - padding.vertical,
                child: FittedBox(child: AppCircularProgressIndicator(color: foregroundColor)),
              )
            : icon,
      ),
      SizedBox(width: gap),
      Flexible(child: label),
    ];

    if (reversed) {
      items = items.reversed.toList();
    }

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        disabledForegroundColor: disabledForegroundColor,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: AppStyles.s14w400Roboto,
        minimumSize: Size(
          expandedWith ? double.infinity : width,
          height,
        ),
        alignment: alignment,
      ),
      onPressed: isLoading ? () {} : onPressed,
      onLongPress: isLoading ? () {} : onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      child: Row(mainAxisSize: MainAxisSize.min, children: items),
    );
  }
}
