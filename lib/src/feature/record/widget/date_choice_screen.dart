import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';

import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_event.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_state.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timetable/timetable_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timetable/timetable_event.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timetable/timetable_state.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:table_calendar/table_calendar.dart';
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
  bool expanded = false;

  DateTime _selectedDay = DateTime.now().subtract(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimetableBloc>(context).add(
      /// TODO: Fetch from choice.
      const TimetableEvent.fetchEmployeeTimetables(3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: BlocBuilder<TimetableBloc, TimetableState>(
        builder: (context, state) {
          return CustomScrollView(
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
                          if (enabledDayPredicate(
                              selectedDay, state.timetables)) {
                            visible = true;
                            expanded = !expanded;
                            _selectedDay = selectedDay;
                            setState(() {});

                            context.read<TimeblockBloc>().add(
                                  TimeblockEvent.fetchEmployeeTimeblocks(
                                    EmployeeTimeblock$Body(
                                      dateAt: selectedDay,
                                      employeeId: 3,
                                      salonId: 1,
                                    ),
                                  ),
                                );
                          }
                        },
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        enabledDayPredicate: (day) => enabledDayPredicate(
                          day,
                          state.timetables,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimeblocsWrap(
                        visible: visible,
                        expanded: expanded,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  bool enabledDayPredicate(
      DateTime day, List<TimetableItem> employeeTimetable) {
    if (day.isAfterAsNow()) {
      return employeeTimetable.any(
        (timetable) =>
            timetable.dateAt.year == day.year &&
            timetable.dateAt.month == day.month &&
            timetable.dateAt.day == day.day,
      );
    } else {
      return false;
    }
  }
}

class TimeblocsWrap extends StatelessWidget {
  const TimeblocsWrap({super.key, this.visible = false, this.expanded = false});

  final bool visible;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeblockBloc, TimeblockState>(
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: expanded ? Alignment.topCenter : Alignment.topCenter,
          child: AnimatedOpacity(
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
                  ...state.timeblocks.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        backgroundColor: context.colorScheme.primary,
                        side: const BorderSide(color: Color(0xFF272727)),
                        label: Text(
                          e.time.substring(0, e.time.length - 3),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onBackground,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
