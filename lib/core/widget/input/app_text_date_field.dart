import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/theme.dart';
import '../../utils/formatter_utils.dart';
import '../image/app_icon.dart';
import 'app_text_form_field.dart';

class AppTextDateField extends AppTextFormField {
  AppTextDateField({
    super.key,
    super.keyboardType = TextInputType.datetime,
    super.textInputAction = TextInputAction.done,
    super.style = AppStyles.s13w400Roboto,
    super.validator,
    super.onSaved,
    super.readOnly = true,
    super.enabled,
    super.hintText,
    this.initial,
    this.onDateChanged,
    DateFormat? dateFormat,
    this.borderSide = const BorderSide(),
    super.prefixIcon = const AppIcon(AppIcons.calender, size: 16, padding: EdgeInsets.symmetric(horizontal: 12)),
    super.prefixIconConstraints = const BoxConstraints(maxHeight: 24),
    super.textAlign,
    this.disable = false,
  }) : dateFormat = dateFormat ?? DateTimeFormatter.dateFormatHyphen;

  final DateTime? initial;
  final ValueChanged<DateTime>? onDateChanged;
  final DateFormat dateFormat;
  final BorderSide borderSide;
  final bool disable;

  @override
  State<AppTextDateField> createState() => _AppTextDateFieldState();
}

class _AppTextDateFieldState extends AppTextFormFieldState<AppTextDateField> {
  final DateTime now = DateTime.now();
  late DateTime _selected = widget.initial ?? now;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) controller.text = widget.dateFormat.format(widget.initial!);
  }

  @override
  InputDecoration buildDecoration(BuildContext context) {
    final AppColors appColors = context.appColors;
    final InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: widget.borderSide,
    );

    return super.buildDecoration(context).copyWith(
          border: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder.copyWith(
            borderSide: widget.borderSide.copyWith(color: appColors.buttonOulineBoder),
          ),
          fillColor: widget.disable ? null : appColors.background,
        );
  }

  @override
  void onFieldChange(String value) {
    super.onFieldChange(value);

    onDateTimeChange(DateTime.tryParse(value));
  }

  void onDateTimeChange(DateTime? dateTime) {
    if (dateTime == null) return;

    _selected = dateTime;
    widget.onDateChanged?.call(_selected);

    controller.text = widget.dateFormat.format(_selected);
  }

  @override
  Future<void> onTap() async {
    if (widget.disable) return;

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );

    onDateTimeChange(dateTime);
  }
}
