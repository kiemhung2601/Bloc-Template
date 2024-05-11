import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_text_form_field.dart';

class AppTextOutlineField extends AppTextFormField {
  const AppTextOutlineField({
    super.key,
    super.enabled,
    super.suffixIcon,
    super.suffixIconConstraints,
    super.hintText,
    super.maxLines,
    super.expands,
    super.fillColor,
    super.initialValue,
    super.readOnly,
    super.textAlign,
    super.keyboardType,
  });

  @override
  State<AppTextOutlineField> createState() => _AppTextOutlineFieldState();
}

class _AppTextOutlineFieldState extends AppTextFormFieldState<AppTextOutlineField> {
  @override
  InputDecoration buildDecoration(BuildContext context) {
    final AppColors appColors = context.appColors;
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: context.appColors.divider),
    );

    return super.buildDecoration(context).copyWith(
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          fillColor: widget.fillColor ?? appColors.background,
        );
  }
}
