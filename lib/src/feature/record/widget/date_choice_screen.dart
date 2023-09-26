import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';

import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timeblock/timeblock_event.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timetable/timetable_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timetable/timetable_event.dart';
import 'package:ln_studio/src/feature/record/bloc/date/timetable/timetable_state.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:ln_studio/src/feature/record/widget/components/timeblocks_wrap.dart';
import 'package:table_calendar/table_calendar.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import 'components/custom_table_calendar.dart';

///
class DateChoiceScreen extends StatefulWidget {
  const DateChoiceScreen({
    super.key,
    required this.employeeId,
  });

  final int employeeId;

  @override
  State<DateChoiceScreen> createState() => _DateChoiceScreenState();
}

class _DateChoiceScreenState extends State<DateChoiceScreen> {
  ///
  bool visible = false;

  ///
  bool expanded = false;

  ///
  DateTime _selectedDay = DateTime.now().subtract(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TimetableBloc>(context).add(
      TimetableEvent.fetchEmployeeTimetables(widget.employeeId),
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
                        onDaySelected: (selectedDay, focusedDay) =>
                            onDaySelected(
                                selectedDay, focusedDay, state.timetables),
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
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

  ///
  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    List<TimetableItem> timetables,
  ) {
    if (enabledDayPredicate(selectedDay, timetables)) {
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
  }

  ///
  bool enabledDayPredicate(DateTime day, List<TimetableItem> timetables) {
    if (day.isAfterAsNow()) {
      return timetables.any(
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
