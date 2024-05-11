import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/theme.dart';
import '../../utils/string_utils.dart';
import '../view/progress_indicator.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    this.padding = EdgeInsets.zero,
    double? size = AppDimens.iconSize,
    this.colorFilter,
    this.alignment = Alignment.center,
    this.fit = BoxFit.cover,
    super.key,
  })  : onPressed = null,
        width = size,
        height = size;

  const AppIcon.rect(
    this.icon, {
    this.padding = EdgeInsets.zero,
    this.width = AppDimens.iconSize,
    this.height = AppDimens.iconSize,
    this.colorFilter,
    this.alignment = Alignment.center,
    this.fit = BoxFit.cover,
    super.key,
  }) : onPressed = null;

  const AppIcon.button(
    this.icon, {
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    double? size = AppDimens.iconSize,
    this.colorFilter,
    this.alignment = Alignment.center,
    this.fit = BoxFit.cover,
    super.key,
  })  : width = size,
        height = size;

  final String? icon;

  final double? width, height;

  final BoxFit fit;

  final ColorFilter? colorFilter;

  final AlignmentGeometry alignment;

  final VoidCallback? onPressed;

  final EdgeInsetsGeometry padding;

  static ColorFilter fillColor(Color color) => ColorFilter.mode(color, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    if (icon?.isEmpty ?? true) {
      return SizedBox.square(dimension: width ?? height, child: const AppCircularProgressIndicator());
    }

    Widget? result;

    if (StringUtils.isURL(icon!)) {
      result = SvgPicture.network(
        icon!,
        width: width,
        height: height,
        alignment: alignment,
        fit: fit,
        colorFilter: colorFilter,
      );
    }

    result ??= SvgPicture.asset(
      icon!,
      width: width,
      height: height,
      alignment: alignment,
      fit: fit,
      colorFilter: colorFilter,
    );

    if (onPressed != null) {
      result = IconButton(alignment: alignment, padding: padding, onPressed: onPressed, icon: result);
    } else {
      result = Padding(padding: padding, child: result);
    }

    if (width != null && height != null) {
      result = SizedBox(
        width: width! + padding.horizontal,
        height: height! + padding.vertical,
        child: result,
      );
    }

    return result;
  }
}
