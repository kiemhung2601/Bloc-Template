import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../button/app_elevated_button.dart';
import 'app_text_form_field.dart';

class AppTextSearchField extends AppTextFormField implements PreferredSizeWidget {
  const AppTextSearchField({
    super.key,
    super.onFieldSubmitted,
    super.hintText,
    this.hintStyle,
    super.suffixIcon,
    super.suffixIconConstraints,
    this.height = 40.0,
  });

  final TextStyle? hintStyle;
  final double height;

  @override
  State<AppTextSearchField> createState() => _AppTextSearchFieldState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppTextSearchFieldState extends AppTextFormFieldState<AppTextSearchField> {
  @override
  InputDecoration buildDecoration(BuildContext context) {
    final AppColors appColors = context.appColors;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

    return super.buildDecoration(context).copyWith(
          fillColor: appColors.background,
          hintStyle: widget.hintStyle ?? AppStyles.s14w400Roboto.copyWith(color: context.appColors.textFieldHintText),
          border: border,
          enabledBorder: border.copyWith(borderSide: BorderSide(color: context.appColors.divider)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: super.build(context)),
        const SizedBox(width: 6),
        AppElevatedButton(
          height: widget.height,
          expandedWith: false,
          borderRadius: BorderRadius.circular(10),
          onPressed: () => widget.onFieldSubmitted?.call(controller.text),
          child: Text(context.l10n.search),
        )
      ],
    );
  }
}
