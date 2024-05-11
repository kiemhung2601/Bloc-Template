import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';

/// If you making a `AppTextFormField` where you require save, reset, or validate
class AppTextFormField extends TextField {
  const AppTextFormField({
    super.key,
    // Form
    this.fieldKey,
    super.restorationId,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    // Text field
    super.controller,
    super.focusNode,
    super.keyboardType = TextInputType.text,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.sentences,
    super.style = AppStyles.s13w400Roboto,
    super.textAlign = TextAlign.start,
    super.textAlignVertical = TextAlignVertical.center,
    super.textDirection,
    super.readOnly = false,
    super.showCursor = true,
    super.autofocus = false,
    super.autocorrect = true,
    super.obscureText = false,
    super.enableSuggestions = true,
    super.enabled,
    super.minLines,
    super.maxLength = 200,
    super.onChanged,
    this.onEditingEnd,
    this.onFocusChange,
    super.onEditingComplete,
    super.onTap,
    super.inputFormatters,
    // Decoration
    this.fillColor,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.label,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.suffixIconConstraints = const BoxConstraints(maxHeight: 24),
    this.prefixIconConstraints = const BoxConstraints(maxHeight: 24),
    super.decoration = null,
    this.contentPadding = const EdgeInsets.all(10),
    this.isDense = true,
    // Scroll
    super.expands = false,
    super.maxLines = 1,
    super.scrollController,
    super.scrollPhysics,
    this.enableInteractiveSelectionOption = true,
  });

  // Decoration
  final Color? fillColor;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? label;
  final String? hintText;
  final String? errorText;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsets? contentPadding;
  final bool isDense;
  // Form
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onEditingEnd;
  final ValueChanged<bool>? onFocusChange;
  final bool enableInteractiveSelectionOption;

  @override
  State<AppTextFormField> createState() => AppTextFormFieldState();
}

class AppTextFormFieldState<T extends AppTextFormField> extends State<T> with TextFieldHandler {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      onChanged: onFieldChange,
      onTap: onTap,
      decoration: buildDecoration(context),
      obscuringCharacter: '*',
      cursorColor: context.colorScheme.onBackground,
      showCursor: widget.showCursor,
      style: widget.style,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: buildInputFormatters(context),
      // Scroll
      expands: widget.expands,
      maxLines: widget.maxLines,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      // Form
      onSaved: widget.onSaved,
      validator: buildValidator(context),
      restorationId: widget.restorationId,
      autovalidateMode: AutovalidateMode.disabled,
      enableInteractiveSelection: widget.enableInteractiveSelectionOption,
    );
  }

  FormFieldValidator<String>? buildValidator(BuildContext context) => widget.validator;

  List<TextInputFormatter>? buildInputFormatters(BuildContext context) => widget.inputFormatters;

  bool get obscureText => widget.obscureText;

  InputDecoration buildDecoration(BuildContext context) {
    if (widget.decoration != null) return widget.decoration!;

    final AppColors colors = context.appColors;

    final InputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(color: colors.textFieldUnderLine),
      borderRadius: BorderRadius.zero,
    );

    Color backgroundColor = colors.textFieldBackground;
    if (widget.readOnly || widget.enabled == false) backgroundColor = colors.textFieldBackgroundReadOnly;
    if (fieldState?.errorText?.isNotEmpty ?? false) backgroundColor = colors.textFieldBackgroundError;

    return InputDecoration(
      prefix: widget.prefix,
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: widget.prefixIconConstraints,
      suffix: widget.suffix,
      suffixIcon: widget.suffixIcon,
      contentPadding: widget.contentPadding,
      counterText: '',
      filled: true,
      isDense: widget.isDense,
      suffixIconConstraints: widget.suffixIconConstraints,
      fillColor: widget.fillColor ?? backgroundColor,
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      errorBorder: border,
      hintText: widget.hintText,
      hintStyle: widget.style?.copyWith(color: colors.textFieldHintText),
      errorMaxLines: 2,
      errorText: widget.errorText,
      errorStyle: widget.style?.copyWith(color: colors.textFieldErrorText),
      label: widget.label,
      labelStyle: widget.style,
      floatingLabelStyle: widget.style,
    );
  }
}

mixin TextFieldHandler<T extends AppTextFormField> on State<T> {
  FocusNode? _focusNode;
  Timer? _debounce;
  GlobalKey<FormFieldState<String>>? fieldKey;
  TextEditingController? _controller;

  FormFieldState<String>? get fieldState => fieldKey?.currentState;

  FocusNode get focusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController get controller {
    return widget.controller ?? (_controller ??= TextEditingController(text: widget.initialValue));
  }

  @override
  void initState() {
    fieldKey ??= widget.fieldKey ?? GlobalKey<FormFieldState<String>>();
    super.initState();
    focusNode.addListener(onFocusChange);
    controller.addListener(onControllerChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(onFocusChange);
    controller.removeListener(onControllerChange);
    super.dispose();
    _focusNode?.dispose();
    _debounce?.cancel();
    _controller?.dispose();
  }

  void onFocusChange() {
    if (!focusNode.hasFocus) {
      setState(() => fieldState?.validate());
    }
    widget.onFocusChange?.call(focusNode.hasFocus);
  }

  void onControllerChange() {
    fieldState?.didChange(controller.text);
    if (fieldState?.isValid ?? false) {
      setState(() => fieldState?.validate());
    }
  }

  void onFieldChange(String value) {
    widget.onChanged?.call(value);
    if (fieldState?.isValid ?? false) {
      setState(() => fieldState?.validate());
    }
    if (widget.onEditingEnd != null) {
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }
      _debounce = Timer(AppParams.delayInputEnd, () {
        widget.onEditingEnd!(fieldState?.value ?? '');
      });
    }
  }

  void onTap() => widget.onTap?.call();
}
