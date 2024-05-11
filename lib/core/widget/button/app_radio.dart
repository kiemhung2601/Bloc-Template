import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.primary,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? primary;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return Radio<T>(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(vertical: -4, horizontal: -3.5),
      activeColor: primary ?? colors.foreground,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
