import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../button/app_icon_button.dart';
import 'app_text_form_field.dart';

/// Use navigation with result type [String]
typedef AppTextCommonFieldNavigationResult = FutureOr<String?> Function();

class AppTextCommonField extends AppTextFormField {
  const AppTextCommonField({
    super.key,
    super.showCursor = false,
    super.readOnly = true,
    super.textAlign,
    super.hintText,
    super.initialValue,
    super.controller,
    super.validator,
    super.suffixIcon = const Icon(Icons.keyboard_arrow_right),
    super.suffixIconConstraints,
    this.suffixIconPadding = EdgeInsets.zero,
    this.onPressed,
    this.onPressedResult,
  }) : super(enabled: onPressed != null || onPressedResult != null);

  final EdgeInsetsGeometry suffixIconPadding;
  final VoidCallback? onPressed;
  final AppTextCommonFieldNavigationResult? onPressedResult;

  @override
  State<AppTextCommonField> createState() => _AppTextCommonFieldState();
}

class _AppTextCommonFieldState extends AppTextFormFieldState<AppTextCommonField> {
  @override
  InputDecoration buildDecoration(BuildContext context) {
    final AppColors appColors = context.appColors;
    final InputDecoration inputDecoration = super.buildDecoration(context);

    return inputDecoration.copyWith(
      fillColor: appColors.background,
      suffixIcon: AppIconButton(
        primary: appColors.foreground,
        padding: widget.suffixIconPadding,
        icon: inputDecoration.suffixIcon ?? const Icon(Icons.keyboard_arrow_right),
        onPressed: _onPressed(),
      ),
    );
  }

  VoidCallback? _onPressed() {
    if (widget.onPressedResult != null) {
      return () async {
        final String? result = await widget.onPressedResult?.call();

        if (result != null) controller.text = result;
      };
    }

    return widget.onPressed;
  }
}
