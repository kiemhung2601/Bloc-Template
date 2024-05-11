import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../extension/extenstion.dart';
import '../../theme/app_styles.dart';
import '../../utils/utils.dart';
import '../button/app_icon_button.dart';
import 'app_text_form_field.dart';

enum AlignViews { input, add, sub }

class AppTextQuantityField extends AppTextFormField {
  const AppTextQuantityField(
      {super.key,
      super.textAlign = TextAlign.left,
      super.keyboardType = TextInputType.phone,
      super.style = AppStyles.s13w400Roboto,
      super.validator,
      super.onSaved,
      super.hintText,
      super.readOnly,
      this.initial,
      this.minimun = 0,
      this.maximun,
      this.onQuantityChanged,
      this.alignViews = const [AlignViews.sub, AlignViews.input, AlignViews.add],
      this.border,
      super.fillColor,
      super.enabled,
      super.controller,
      super.inputFormatters});

  final int? initial, minimun, maximun;
  final ValueChanged<int?>? onQuantityChanged;
  final InputBorder? border;
  final List<AlignViews> alignViews;

  @override
  State<AppTextQuantityField> createState() => _AppTextQuantityFieldState();
}

class _AppTextQuantityFieldState extends AppTextFormFieldState<AppTextQuantityField> {
  @override
  void initState() {
    super.initState();
    controller.text = widget.initial?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.alignViews.map(mapAlignViewsToElement).toList().applySeparator(const SizedBox(width: 7)),
    );
  }

  Widget mapAlignViewsToElement(AlignViews view) => switch (view) {
        AlignViews.add => Container(
            width: 40,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: context.appColors.textFieldHintText),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppIconButton(
              size: 30,
              primary: context.appColors.primary,
              icon: const Icon(Icons.add),
              onPressed: widget.enabled ?? true ? plus : null,
            ),
          ),
        AlignViews.sub => Container(
            width: 40,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: context.appColors.textFieldHintText),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppIconButton(
              size: 30,
              primary: context.appColors.error,
              icon: const Icon(Icons.remove),
              onPressed: widget.enabled ?? true ? minus : null,
            ),
          ),
        AlignViews.input => Expanded(child: super.build(context)),
      };

  void minus() {
    final int quantity = (int.tryParse(controller.text.replaceAll(',', '')) ?? 0) - 1;
    if (widget.minimun != null && quantity < widget.minimun!) return;

    final String text = quantity.toString();
    controller.value = TextEditingValue(
        text: StringUtils.formatThousands(num.tryParse(text) ?? 0),
        selection: TextSelection.collapsed(offset: text.length));

    widget.onQuantityChanged?.call(quantity);
  }

  void plus() {
    final int quantity = (int.tryParse(controller.text.replaceAll(',', '')) ?? 0) + 1;
    if (widget.maximun != null && quantity > widget.maximun!) return;

    final String text = quantity.toString();
    controller.value = TextEditingValue(
        text: StringUtils.formatThousands(num.tryParse(text) ?? 0),
        selection: TextSelection.collapsed(offset: text.length));

    widget.onQuantityChanged?.call(quantity);
  }

  @override
  void onFieldChange(String value) {
    super.onFieldChange(value);

    widget.onQuantityChanged?.call(int.tryParse(value.replaceAll(',', '')) ?? 0);
  }

  @override
  List<TextInputFormatter>? buildInputFormatters(BuildContext context) {
    return [FilteringTextInputFormatter.digitsOnly, ...?super.buildInputFormatters(context)];
  }

  @override
  InputDecoration buildDecoration(BuildContext context) {
    return super.buildDecoration(context).copyWith(border: widget.border, enabledBorder: widget.border);
  }
}
