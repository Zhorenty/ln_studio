import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/utils/extensions/color_extension.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

///
class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({
    super.key,
    this.onDaySelected,
    this.selectedDayPredicate,
    this.enabledDayPredicate,
  });

  ///
  final void Function(DateTime, DateTime)? onDaySelected;

  ///
  final bool Function(DateTime)? selectedDayPredicate;

  ///
  final bool Function(DateTime)? enabledDayPredicate;

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
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: context.textTheme.bodyLarge!.copyWith(
            fontFamily: FontFamily.geologica,
          ),
          leftChevronVisible: false,
          rightChevronVisible: false,
        ),
        selectedDayPredicate: selectedDayPredicate,
        enabledDayPredicate: enabledDayPredicate,
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
            color: context.colorScheme.secondary,
          ),
          defaultTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.secondary,
          ),
          holidayTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
          ),
          weekendTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer.darken(0.5),
          ),
          outsideTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer.darken(0.5),
          ),

          // Decorations
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.primary,
          ),
          disabledDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.scrim,
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.scrim,
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.scrim,
          ),
          holidayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.scrim,
          ),
          outsideDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.scrim,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.scrim,
          ),
        ),
      ),
    );
  }
}
