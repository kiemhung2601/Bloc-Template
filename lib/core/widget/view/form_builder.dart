import 'package:flutter/material.dart';

typedef IndexedTableBuilder = Widget Function(int rowIndex, int columnIndex);

class TableForm extends StatelessWidget {
  const TableForm({
    super.key,
    this.border,
    this.defaultVerticalAlignment = TableCellVerticalAlignment.middle,
    this.columnWidths = const {
      0: IntrinsicColumnWidth(flex: 0.25), // Min: 1/4
      1: FlexColumnWidth(),
    },
    required this.children,
  });

  final TableBorder? border;
  final TableCellVerticalAlignment defaultVerticalAlignment;
  final Map<int, TableColumnWidth> columnWidths;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: border,
      defaultVerticalAlignment: defaultVerticalAlignment,
      columnWidths: columnWidths,
      children: _buildTableRows().toList(),
    );
  }

  Iterable<TableRow> _buildTableRows() sync* {
    final int totalColumn = columnWidths.entries.length;
    final int totalRow = children.length ~/ totalColumn;

    for (var i = 0; i < totalRow; i++) {
      yield TableRow(children: children.skip(i * totalColumn).take(totalColumn).toList());
    }
  }
}
