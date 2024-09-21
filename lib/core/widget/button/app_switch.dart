import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.primary,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? primary;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      // data: Theme.of(context).copyWith(useMaterial3: false),
      child: Switch(
        value: value,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          } else if (states.contains(WidgetState.selected)) {
            return const Color(0xFF2853E5);
          } else if (states.contains(WidgetState.pressed)) {
            return const Color(0xFFC4C7D0);
          }

          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          } else if (states.contains(WidgetState.selected)) {
            return const Color(0xFFADBBEA);
          } else if (states.contains(WidgetState.pressed)) {
            return const Color(0xFF36343B);
          }

          return null;
        }),
        overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          } else if (states.contains(WidgetState.selected)) {
            return const Color(0xFF4C6EE0).withOpacity(0.12);
          } else if (states.contains(WidgetState.pressed)) {
            return const Color(0xFFE0E4E9).withOpacity(0.12);
          }

          return null;
        }),
      ),
    );
  }
}
