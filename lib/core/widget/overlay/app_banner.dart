import 'package:flutter/material.dart';

import 'app_overlay.dart';

class AppBanner extends AppOverlay {
  const AppBanner({
    super.key,
    this.banner,
    required super.controller,
    required super.child,
  });

  final Widget? banner;

  @override
  State<AppBanner> createState() => AppBannerState();
}

class AppBannerState extends AppOverlayState<AppBanner> with AppOverlayUseTimer {
  @override
  Widget buildOverlay(BuildContext context, Offset target, Widget? overlay) {
    return AlignTransition(
      alignment: animationController.drive(Tween<AlignmentGeometry>(
        begin: Alignment.topCenter,
        end: const Alignment(0, -0.8),
      )),
      child: Material(type: MaterialType.transparency, child: widget.banner),
    );
  }
}
