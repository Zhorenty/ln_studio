import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:table_calendar/table_calendar.dart';

///
class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({super.key, this.onDaySelected});

  ///
  final void Function(DateTime, DateTime)? onDaySelected;

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
            rightChevronVisible: false),
        calendarStyle: CalendarStyle(
          todayTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onBackground,
          ),
          selectedTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.background,
          ),
          defaultTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
          ),
          holidayTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer,
          ),
          outsideTextStyle: context.textTheme.titleSmall!.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer,
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
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.primary,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: context.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
