import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../theme/theme.dart';
import 'app_text_form_field.dart';

class AppAutocomplete<T extends Object> extends StatelessWidget {
  const AppAutocomplete({
    super.key,
    required this.optionsBuilder,
    required this.onSubmitted,
    this.fieldViewBuilder,
    this.onSelected,

    /// Input view
    this.fieldKey,
    this.initialValue,
    this.focusNode,
    this.textEditingController,
    this.onEditingEnd,
    this.hintText,

    /// Option view
    this.itemStyle = AppStyles.s14w400Roboto,
    this.maxLines = 1,

    /// Event
    this.tapOptionSubmit = true, // Auto submit after selecting suggestion
    this.autoFillOption = true, // Automatically change suggestions after submitting
  });

  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final ValueChanged<T> onSubmitted;
  final AutocompleteFieldViewBuilder? fieldViewBuilder;
  final AutocompleteOnSelected<T>? onSelected;
  // Input view
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onEditingEnd;
  final String? hintText;
  // Option view
  final TextStyle itemStyle;
  final int? maxLines;
  // Event
  final bool tapOptionSubmit;
  final bool autoFillOption;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return RawAutocomplete<T>(
        initialValue: (initialValue == null)
            ? null
            : TextEditingValue(
                text: initialValue!,
                selection: TextSelection.collapsed(offset: initialValue!.length),
              ),
        focusNode: focusNode,
        textEditingController: textEditingController,
        onSelected: onSelected,
        optionsBuilder: optionsBuilder,
        optionsViewBuilder: (context, selected, options) => _optionsViewBuilder(
          context,
          selected,
          options,
          constraints,
        ),
        fieldViewBuilder: fieldViewBuilder ?? _fieldViewBuilder,
      );
    });
  }

  Widget _optionsViewBuilder(
    BuildContext context,
    AutocompleteOnSelected<T> onSelected,
    Iterable<T> options,
    BoxConstraints constraints,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 150,
            maxWidth: constraints.biggest.width,
          ),
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colorScheme.primary),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withOpacity(0.24),
                blurRadius: 10,
              )
            ],
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return _optionsViewItemBuilder(
                context,
                index,
                onSelected,
                options,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _optionsViewItemBuilder(
    BuildContext context,
    int index,
    AutocompleteOnSelected<T> onSelected,
    Iterable<T> options,
  ) {
    final T option = options.elementAt(index);
    final bool highlight = AutocompleteHighlightedOption.of(context) == index;

    return InkWell(
      onTap: () {
        onSelected(option);
        if (tapOptionSubmit) {
          FocusScope.of(context).unfocus();
          onSubmitted(option);
        }
      },
      child: Container(
        color: highlight ? context.colorScheme.primary : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        alignment: Alignment.centerLeft,
        child: Builder(builder: (context) {
          if (highlight) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Scrollable.ensureVisible(context, alignment: 0.5);
            });
          }
          return Text(
            RawAutocomplete.defaultStringForOption(option),
            style: itemStyle,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
        }),
      ),
    );
  }

  //  Default UI search
  Widget _fieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return AppTextFormField(
      fieldKey: fieldKey,
      controller: textEditingController,
      focusNode: focusNode,
      hintText: hintText,
      onFieldSubmitted: (value) {
        if (value is T) {
          onSubmitted(value as T);
        }
      },
      onEditingEnd: onEditingEnd,
      onEditingComplete: autoFillOption ? onFieldSubmitted : null,
    );
  }
}
