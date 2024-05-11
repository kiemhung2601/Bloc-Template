import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_overlay.dart';

class AppTooltip extends AppOverlay {
  const AppTooltip({
    super.key,
    this.autoClose = true,
    super.controller,
    required this.message,
    required super.child,
  });

  final bool autoClose;
  final String message;

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends AppOverlayState<AppTooltip> with AppOverlayUseTimer {
  @override
  double get verticalOffset => 20;

  @override
  Widget buildOverlay(BuildContext context, Offset target, Widget? overlay) {
    final AppColors colors = context.appColors;

    overlay = Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.imageBackground),
      child: Text(widget.message, style: context.textStyle.titleMedium),
    );

    return super.buildOverlay(context, target, overlay);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: overlayController.showOverlay,
      child: super.build(context),
    );
  }
}
