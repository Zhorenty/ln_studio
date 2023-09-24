import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import 'components/custom_table_calendar.dart';

class DateChoiceScreen extends StatefulWidget {
  const DateChoiceScreen({super.key});

  @override
  State<DateChoiceScreen> createState() => _DateChoiceScreenState();
}

class _DateChoiceScreenState extends State<DateChoiceScreen> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'Выберите дату',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTableCalendar(
                    onDaySelected: (selectedDay, focusedDay) {
                      visible = !visible;
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomChipWrap(
                    visible: visible,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomChipWrap extends StatelessWidget {
  const CustomChipWrap({
    super.key,
    this.visible = false,
  });

  final bool visible;

  @override
  Widget build(BuildContext context) {
    List<DateTime> createDateTimeList() {
      List<DateTime> dateTimeList = [];
      DateTime currentTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        8,
        0,
      );

      // final dateFormat = DateFormat('HH:mm');

      while (currentTime.hour < 21) {
        dateTimeList.add(currentTime);
        currentTime = currentTime.add(const Duration(minutes: 30));
      }

      return dateTimeList;
    }

    List<DateTime> dateTimeList = createDateTimeList();
    final dateFormat = DateFormat('HH:mm');

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: visible ? 1 : 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: Wrap(
          children: [
            for (DateTime dateTime in dateTimeList)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  backgroundColor: context.colorScheme.onBackground,
                  side: const BorderSide(color: Color(0xFF272727)),
                  label: Text(
                    dateFormat.format(dateTime),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.secondary,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
