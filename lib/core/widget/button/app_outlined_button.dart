import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../view/progress_indicator.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.child,
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
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.borderWidth = 1.0,
    this.textStyle = AppStyles.s14w400Roboto,
    this.backgroundColor,
  });

  final Widget child;

  final Color? primary;

  final Color? backgroundColor;

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

  final double borderWidth;

  final TextStyle textStyle;

  bool get isDisable => onPressed == null;

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor = primary ?? context.colorScheme.primary;
    final Color disabledForegroundColor = primary ?? context.colorScheme.onSurface.withOpacity(0.2);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledForegroundColor: disabledForegroundColor,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        side: BorderSide(color: isDisable ? disabledForegroundColor : foregroundColor, width: borderWidth),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: textStyle,
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
      child: RepaintBoundary(
          key: UniqueKey(),
          child: AnimatedSize(
            duration: AppParams.animationDurationFast,
            curve: Curves.fastOutSlowIn,
            child: isLoading
                ? SizedBox(
                    height: height - padding.vertical,
                    child: FittedBox(child: AppCircularProgressIndicator(color: foregroundColor)),
                  )
                : child,
          )),
    );
  }
}
