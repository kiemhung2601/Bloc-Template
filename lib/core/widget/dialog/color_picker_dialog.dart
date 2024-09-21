import 'package:flutter/material.dart';

import '../../extension/context_extension.dart';
import '../button/app_elevated_button.dart';
import 'default_dialog.dart';

extension ColorPickerDialogExt on BuildContext {
  Future<Color?> showColorPickerDialog(ColorPickerDialog dialog) => showDialog(
        context: this,
        builder: (BuildContext context) => dialog,
      );
}

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key, required this.title});

  final String title;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();

  static const Map<String, Color> _items = {
    'GRAY': Color(0xFFD0D5DD),
    'BLACK': Color(0xFF475467),
    'BLUE': Color(0xFFA4BCFD),
    'YELLOW': Color(0xFFF9EB71),
    'RED': Color(0xFFFEA3B4),
    'PURPLE': Color(0xFFD1B8F1),
    'GREEN': Color(0xFF6CE9A6),
    'ORANGE': Color(0xFFFEB273),
  };

  static Color toColor(String? text) {
    return _items.entries
        .firstWhere((element) => element.key == text, orElse: () => const MapEntry('BLACK', Colors.black))
        .value;
  }

  static String toText(Color? color) {
    return _items.entries
        .firstWhere((element) => element.value == color, orElse: () => const MapEntry('BLACK', Colors.black))
        .key;
  }
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color? itemSelected;

  @override
  Widget build(BuildContext context) {
    return DefaultDialog.common(
      iconClose: true,
      title: Text(widget.title),
      content: GridView.builder(
        shrinkWrap: true,
        itemCount: ColorPickerDialog._items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: _buildItems,
      ),
      action: AppElevatedButton(
        height: 40,
        onPressed: itemSelected == null ? null : () => Navigator.of(context).pop(itemSelected),
        child: Text(context.l10n.confirm),
      ),
    );
  }

  Widget? _buildItems(BuildContext context, int index) {
    final Color item = ColorPickerDialog._items.entries.elementAt(index).value;
    final BorderSide borderSide = itemSelected == item
        ? BorderSide(color: context.colorScheme.primary)
        : const BorderSide(width: 0.5, color: Color(0xFFD9D9D9));

    return GestureDetector(
      onTap: () => setState(() => itemSelected = item),
      child: Container(
        width: 40,
        height: 40,
        decoration: ShapeDecoration(color: item, shape: OvalBorder(side: borderSide)),
      ),
    );
  }
}
