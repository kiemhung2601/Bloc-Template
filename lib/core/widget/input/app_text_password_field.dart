import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../image/app_icon.dart';
import 'app_text_form_field.dart';

class AppTextPasswordField extends AppTextFormField {
  const AppTextPasswordField({
    super.key,
    this.suffixIconSize = 20,
    // Form
    super.fieldKey,
    super.initialValue,
    super.validator,
    super.onSaved,
    super.onFieldSubmitted,
    // Handler
    super.controller,
    super.focusNode,
    super.onChanged,
    super.onEditingEnd,
    // Decoration
    super.keyboardType = TextInputType.visiblePassword,
    super.textInputAction = TextInputAction.done,
    super.textCapitalization = TextCapitalization.none,
    super.label,
    super.contentPadding,
    super.hintText,
    super.obscureText = true,
  });

  // Decoration
  final double suffixIconSize;

  @override
  State<AppTextPasswordField> createState() => _AppTextFormPasswordFieldState();
}

class _AppTextFormPasswordFieldState extends AppTextFormFieldState<AppTextPasswordField> {
  @override
  late bool obscureText = widget.obscureText;

  @override
  void onFieldChange(String value) {
    super.onFieldChange(value);
    if (!obscureText) {
      setState(() => obscureText = !obscureText);
    }
  }

  Widget get suffixIcon {
    return AppIcon.button(
      obscureText ? AppIcons.hidePassword : AppIcons.showPassword,
      size: widget.suffixIconSize,
      colorFilter: AppIcon.fillColor(context.appColors.foreground),
      onPressed: () => setState(() => obscureText = !obscureText),
    );
  }

  // @override
  // InputDecoration buildDecoration(context) {
  //   return super.buildDecoration(context).copyWith(suffixIcon: suffixIcon);
  // }
}
