import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

///
class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({
    super.key,
    this.onDaySelected,
    this.selectedDayPredicate,
  });

  ///
  final void Function(DateTime, DateTime)? onDaySelected;

  ///
  final bool Function(DateTime)? selectedDayPredicate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: TableCalendar(
        locale: 'ru_RU',
        firstDay: DateTime.now().subtract(const Duration(days: 30)),
        lastDay: DateTime.now().add(const Duration(days: 30)),
        focusedDay: DateTime.now(),
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: onDaySelected,
        selectedDayPredicate: selectedDayPredicate,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: context.textTheme.bodyLarge!.copyWith(
            fontFamily: FontFamily.geologica,
          ),
          leftChevronVisible: false,
          rightChevronVisible: false,
        ),
        calendarStyle: CalendarStyle(
          // Text styles
          selectedTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.background,
          ),
          todayTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primaryContainer,
          ),
          defaultTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer,
          ),
          holidayTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
          ),
          weekendTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer,
          ),
          outsideTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer,
          ),

          // Decorations
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.primary,
          ),
          defaultDecoration: BoxDecoration(color: context.colorScheme.scrim),
          weekendDecoration: BoxDecoration(color: context.colorScheme.scrim),
          holidayDecoration: BoxDecoration(color: context.colorScheme.scrim),
          outsideDecoration: BoxDecoration(color: context.colorScheme.scrim),
          todayDecoration: BoxDecoration(color: context.colorScheme.scrim),
        ),
      ),
    );
  }
}
