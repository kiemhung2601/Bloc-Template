import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    this.size = 24,
    this.disable = false,
    required this.isSelected,
    required this.onChanged,
  });

  final double size;
  final bool disable;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Checkbox(visualDensity: VisualDensity.compact, value: isSelected, onChanged: disable ? null : onChanged),
    );
  }
}
