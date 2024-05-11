import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../view/progress_indicator.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.padding = AppDimens.buttonPadding,
    this.primary,
    this.onPrimary,
    this.expandedWith = true,
    this.isLoading = false,
    this.alignment,
    this.height = AppDimens.buttonHeight,
    this.width = 0.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  final Widget? child;

  final Color? primary;

  final Color? onPrimary;

  final EdgeInsetsGeometry padding;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onHover;

  final ValueChanged<bool>? onFocusChange;

  final bool expandedWith;

  final AlignmentGeometry? alignment;

  final double height;

  final double width;

  final bool isLoading;

  final BorderRadiusGeometry borderRadius;

  bool get isDisable => onPressed == null;

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor = onPrimary ?? context.colorScheme.onPrimary;
    final Color backgroundColor = primary ?? context.appColors.primary;
    final Color? disabledForegroundColor = onPrimary?.withOpacity(0.2);
    final Color? disabledBackgroundColor = primary?.withOpacity(0.2);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        disabledForegroundColor: disabledForegroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
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
      child: AnimatedSize(
        duration: AppParams.animationDurationFast,
        curve: Curves.fastOutSlowIn,
        child: isLoading
            ? SizedBox(
                height: height - padding.vertical,
                child: FittedBox(child: AppCircularProgressIndicator(color: foregroundColor)),
              )
            : child,
      ),
    );
  }
}
