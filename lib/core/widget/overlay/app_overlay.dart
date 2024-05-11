import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_params.dart';

class AppOverlay extends StatefulWidget {
  const AppOverlay({
    super.key,
    this.controller,
    this.overlay,
    required this.child,
  });

  final AppOverlayController? controller;
  final Widget? overlay;
  final Widget child;

  @override
  State<AppOverlay> createState() => AppOverlayState();
}

class AppOverlayState<T extends AppOverlay> extends State<T> with SingleTickerProviderStateMixin {
  OverlayEntry? _entry;
  AppOverlayController? _overlayController;
  late AnimationController animationController;

  AppOverlayController get overlayController => widget.controller ?? (_overlayController ??= AppOverlayController());
  double get verticalOffset => 30.0;
  bool get preferBelow => false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: AppParams.animationDuration,
      reverseDuration: AppParams.animationDurationFast,
      vsync: this,
    );
    overlayController.addListener(handleStatusChanged);
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(handleStatusChanged);
      _overlayController?.removeListener(handleStatusChanged);
      overlayController.addListener(handleStatusChanged);
    }
  }

  @override
  void dispose() {
    overlayController.removeListener(handleStatusChanged);
    _entry?.remove();
    _entry?.dispose();
    _overlayController?.dispose();
    animationController.dispose();
    super.dispose();
  }

  void handleStatusChanged() {
    setState(() {});

    switch (overlayController.value) {
      case AppOverlayStatus.showing:
        return _createEntry();
      case AppOverlayStatus.hidden:
        return _removeEntry();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget buildOverlay(BuildContext context, Offset target, Widget? overlay) {
    return AppOverlayWidget(
      animation: CurvedAnimation(
        parent: animationController,
        curve: AppParams.animationCurve,
      ),
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      child: overlay,
    );
  }

  void _createEntry() {
    if (!mounted || _entry != null) {
      return;
    }

    final OverlayState overlayState = Overlay.of(context, debugRequiredFor: widget);

    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset target = box.localToGlobal(
      box.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );

    _entry = OverlayEntry(builder: (BuildContext context) => buildOverlay(context, target, widget.overlay));
    overlayState.insert(_entry!);

    animationController.forward();
  }

  void _removeEntry() => animationController.reverse().whenComplete(() {
        _entry?.remove();
        _entry?.dispose();
        _entry = null;
      });

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/* ------------ Components ------------ */

enum AppOverlayStatus {
  showing,
  hidden;

  bool get isShowing => this == AppOverlayStatus.showing;
  bool get isHidden => this == AppOverlayStatus.hidden;
}

class AppOverlayController extends ValueNotifier<AppOverlayStatus> {
  AppOverlayController({AppOverlayStatus? status}) : super(status ?? AppOverlayStatus.hidden);

  AppOverlayStatus get status => value;

  void showOverlay() => value = AppOverlayStatus.showing;

  void hidenOverlay() => value = AppOverlayStatus.hidden;
}

class AppOverlayWidget extends StatelessWidget {
  const AppOverlayWidget({
    super.key,
    required this.animation,
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
    this.child,
  });

  final Animation<double> animation;
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Widget result = FadeTransition(
      opacity: animation,
      child: child,
    );

    return Positioned.fill(
      bottom: MediaQuery.maybeViewInsetsOf(context)?.bottom ?? 0.0,
      child: CustomSingleChildLayout(
        delegate: AppOverlayPositionDelegate(
          target: target,
          verticalOffset: verticalOffset,
          preferBelow: preferBelow,
        ),
        child: Material(type: MaterialType.transparency, child: result),
      ),
    );
  }
}

/// Coppy Material Tooltip [_TooltipPositionDelegate]
class AppOverlayPositionDelegate extends SingleChildLayoutDelegate {
  AppOverlayPositionDelegate({
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  });

  /// The offset of the target the tooltip is positioned near in the global
  /// coordinate system.
  final Offset target;

  /// The amount of vertical distance between the target and the displayed
  /// tooltip.
  final double verticalOffset;

  /// Whether the tooltip is displayed below its widget by default.
  ///
  /// If there is insufficient space to display the tooltip in the preferred
  /// direction, the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      margin: 0,
    );
  }

  @override
  bool shouldRelayout(AppOverlayPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}

/* ------------ Extension Mixin ------------ */

mixin AppOverlayUseFocusNode<T extends AppOverlay> on AppOverlayState<T> {
  FocusNode? _focusNode;
  FocusNode get effectiveFocusNode => _focusNode ??= FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
        focusNode: effectiveFocusNode,
        onFocusChange: (value) {
          if (value) {
            ScrollNotificationObserver.maybeOf(context)?.addListener(handleScrollChanged);
          } else {
            overlayController.hidenOverlay();
            ScrollNotificationObserver.maybeOf(context)?.removeListener(handleScrollChanged);
          }
        },
        child: super.build(context));
  }

  @override
  void handleStatusChanged() {
    if (overlayController.status.isShowing) {
      effectiveFocusNode.requestFocus();
    }
    super.handleStatusChanged();
  }

  void handleScrollChanged(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      Future.delayed(Duration.zero, overlayController.hidenOverlay);
    }
  }
}

mixin AppOverlayUseTimer<T extends AppOverlay> on AppOverlayState<T> {
  Timer? _dismissTimer;

  Duration get timerDuration => const Duration(seconds: 3);

  @override
  void handleStatusChanged() {
    if (overlayController.status.isShowing) {
      _dismissTimer?.cancel();

      _dismissTimer = Timer(timerDuration, overlayController.hidenOverlay);
    }

    super.handleStatusChanged();
  }

  @override
  void dispose() {
    super.dispose();
    _dismissTimer?.cancel();
    _dismissTimer = null;
  }
}
