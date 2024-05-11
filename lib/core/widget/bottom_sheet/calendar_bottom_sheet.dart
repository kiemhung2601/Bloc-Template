import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../extension/context_extension.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../dialog/default_dialog.dart';
import 'default_bottom_sheet.dart';

extension CalendarBottomSheetExtension on BuildContext {}

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    this.initialMonth,
    this.minimumDate,
    this.maximumDate,
  });

  final DateTime? initialMonth;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  Future<DateTime?> showBottomSheet(BuildContext context) => context.showModalDefaultBottomSheet(
        DefaultBottomSheet(child: this),
      );

  Future<DateTime?> showDialog(BuildContext context) => context.showDefaultDialog(
        DefaultDialog(child: this),
      );

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  final DateTime now = DateTime.now();
  late final DateTime initialDate = widget.initialMonth ?? now;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = context.appColors;

    return TableCalendar(
      /// UI
      calendarStyle: const CalendarStyle(outsideDaysVisible: false),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        headerPadding: const EdgeInsets.symmetric(vertical: 18),
        titleTextStyle: AppStyles.s20w700Roboto.copyWith(color: appColors.textGrey),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: appColors.divider))),
      ),
      daysOfWeekHeight: 48,
      rowHeight: 48,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) => MaterialLocalizations.of(context).narrowWeekdays[date.weekday - 1],
        weekdayStyle: AppStyles.s16w400Roboto,
        weekendStyle: AppStyles.s16w400Roboto,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) => CalendarPickerDayItem(day),
        todayBuilder: (context, day, focusedDay) => CalendarPickerDayItem(day, isToday: true),
        selectedBuilder: (context, day, focusedDay) => CalendarPickerDayItem(day, isSeleced: true),
      ),

      /// Config
      locale: context.appTheme.locale?.toString(),
      firstDay: widget.minimumDate ?? DateTime(initialDate.year - 1),
      lastDay: widget.maximumDate ?? DateTime(initialDate.year + 1),

      /// Handle
      focusedDay: _focusedDay,
      onPageChanged: (focusedDay) => _focusedDay = focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDateChanged.call(selectedDay);
        }
      },
    );
  }
}

class CalendarPickerDayItem extends StatelessWidget {
  const CalendarPickerDayItem(
    this.day, {
    super.key,
    this.isToday = false,
    this.isSeleced = false,
  });

  final DateTime day;
  final bool isToday;
  final bool isSeleced;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      decoration: buildDecoration(context),
      alignment: Alignment.center,
      child: Text(day.day.toString(), style: AppStyles.s16w400Roboto.copyWith(color: buildTextColor(context))),
    );
  }

  Decoration? buildDecoration(BuildContext context) {
    final AppColors appColors = context.appColors;

    if (isToday) {
      return BoxDecoration(border: Border.all(color: appColors.primary), shape: BoxShape.circle);
    } else if (isSeleced) {
      return BoxDecoration(color: appColors.primary, shape: BoxShape.circle);
    }

    return null;
  }

  Color? buildTextColor(BuildContext context) {
    if (isSeleced) {
      return Colors.white;
    }

    return null;
  }
}
