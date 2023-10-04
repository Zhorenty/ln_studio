import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

///
class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({
    super.key,
    required this.focusedDay,
    this.onDaySelected,
    this.onPageChanged,
    this.selectedDayPredicate,
    this.enabledDayPredicate,
  });

  final DateTime focusedDay;

  ///
  final void Function(DateTime, DateTime)? onDaySelected;

  final void Function(DateTime)? onPageChanged;

  ///
  final bool Function(DateTime)? selectedDayPredicate;

  ///
  final bool Function(DateTime)? enabledDayPredicate;

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfPreviousMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
      1,
    );
    DateTime lastDayOfNextMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month + 2,
      0,
    );

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: TableCalendar(
        availableGestures: AvailableGestures.horizontalSwipe,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: context.textTheme.labelLarge!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.secondaryContainer,
            fontSize: 13,
          ),
          weekendStyle: context.textTheme.labelLarge!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.secondaryContainer,
            fontSize: 13,
          ),
        ),
        locale: 'ru_RU',
        firstDay: firstDayOfPreviousMonth,
        lastDay: lastDayOfNextMonth,
        focusedDay: focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
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
            color: context.colorScheme.secondary,
          ),
          defaultTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.secondary,
          ),
          holidayTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.secondary,
          ),
          weekendTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.secondary,
          ),
          outsideTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.secondary,
          ),
          disabledTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: const Color(0xFF555555),
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
