import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../view/progress_indicator.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.primary,
    this.isLoading = false,
    this.alignment,
    this.size = AppDimens.iconSize,
  });

  final Widget icon;

  final Color? primary;

  final EdgeInsetsGeometry padding;

  final VoidCallback? onPressed;

  final AlignmentGeometry? alignment;

  final double size;

  final bool isLoading;

  bool get isDisable => onPressed == null;

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor = primary ?? context.colorScheme.primary;
    final Color disabledForegroundColor = context.colorScheme.onSurface.withOpacity(0.2);

    return IconButton(
      style: IconButton.styleFrom(
        foregroundColor: foregroundColor,
        disabledForegroundColor: disabledForegroundColor,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        minimumSize: Size.square(size),
        alignment: alignment,
      ),
      onPressed: isLoading ? () {} : onPressed,
      iconSize: size,
      icon: AnimatedSize(
        duration: AppParams.animationDurationFast,
        curve: Curves.fastOutSlowIn,
        child: isLoading
            ? SizedBox.square(
                dimension: size - padding.vertical,
                child: FittedBox(child: AppCircularProgressIndicator(color: foregroundColor)),
              )
            : icon,
      ),
    );
  }
}
