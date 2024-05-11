import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../input/app_text_form_field.dart';
import 'app_overlay.dart';

typedef ValueBuilder<T> = String Function(BuildContext context, T item);

String _kValueBuilder(BuildContext context, dynamic item) => item.toString();

typedef ItemBuilder<T> = Widget? Function(BuildContext context, T item);

Widget? _kItemBuilder(BuildContext context, dynamic item) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Text(_kValueBuilder(context, item), style: AppStyles.s16w400Roboto, maxLines: 1),
  );
}

typedef AppDropdownFieldViewBuilder = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
);

Widget _kDropdownFieldViewBuilder(BuildContext context, TextEditingController textEditingController) {
  return AppTextFormField(
    enabled: false,
    suffixIcon: const Icon(Icons.arrow_drop_down, size: 20),
    suffixIconConstraints: const BoxConstraints(maxHeight: 40),
    controller: textEditingController,
  );
}

class AppDropdown<T> extends AppOverlay {
  const AppDropdown({
    super.key,
    super.controller,
    this.width,
    this.height,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    this.onChanged,
    this.onIndexChanged,
    this.valueBuilder = _kValueBuilder,
    this.itemBuilder,
    required this.items,
    required super.child,
  });

  final double? width, height;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Iterable<T> items;
  final ValueBuilder<T> valueBuilder;
  final ItemBuilder<T>? itemBuilder;
  final ValueChanged<T>? onChanged;
  final ValueChanged<int>? onIndexChanged;

  @override
  State<AppDropdown> createState() => _AppDropdownState<T, AppDropdown<T>>();
}

class _AppDropdownState<T, State extends AppDropdown<T>> extends AppOverlayState<State> with AppOverlayUseFocusNode {
  final LayerLink _link = LayerLink();

  @override
  Widget buildOverlay(_, Offset target, Widget? overlay) {
    final renderBox = context.findRenderObject() as RenderBox?;

    return Align(
      child: CompositedTransformFollower(
        link: _link,
        showWhenUnlinked: false,
        followerAnchor: widget.followerAnchor,
        targetAnchor: widget.targetAnchor,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              color: context.appColors.background,
              border: Border.all(color: context.appColors.divider),
            ),
            width: widget.width ?? renderBox?.size.width,
            height: widget.height,
            child: SizeTransition(
              axisAlignment: 1,
              sizeFactor: CurvedAnimation(parent: animationController, curve: AppParams.animationCurve),
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 5),
                itemBuilder: (context, index) {
                  final T item = widget.items.elementAt(index);
                  Widget? result = widget.itemBuilder?.call(context, item);
                  result ??= _kItemBuilder(context, widget.valueBuilder(context, item));

                  return GestureDetector(
                    onTap: () => submitDropdown(item, index),
                    child: result,
                  );
                },
                itemCount: widget.items.length,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDropdown,
      child: CompositedTransformTarget(
        link: _link,
        child: super.build(context),
      ),
    );
  }

  void toggleDropdown() {
    if (overlayController.status.isHidden) {
      overlayController.showOverlay();
    } else {
      overlayController.hidenOverlay();
    }
  }

  void submitDropdown(T item, int index) {
    widget.onChanged?.call(item);
    widget.onIndexChanged?.call(index);
    overlayController.hidenOverlay();
  }
}

class AppDropdownBuilder<T> extends AppDropdown<T> {
  const AppDropdownBuilder({
    super.key,
    super.valueBuilder,
    super.itemBuilder,
    super.onChanged,
    required super.items,
    this.fieldViewBuilder = _kDropdownFieldViewBuilder,
  }) : super(child: const SizedBox.shrink());

  final AppDropdownFieldViewBuilder fieldViewBuilder;

  @override
  State<AppDropdown> createState() => _AppDropdownBuilderState<T>();
}

class _AppDropdownBuilderState<T> extends _AppDropdownState<T, AppDropdownBuilder<T>> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDropdown,
      child: CompositedTransformTarget(
        link: _link,
        child: widget.fieldViewBuilder(context, textEditingController),
      ),
    );
  }

  @override
  void submitDropdown(T item, int index) {
    super.submitDropdown(item, index);
    textEditingController.text = widget.valueBuilder(context, item);
  }
}
