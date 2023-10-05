import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';

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
    required this.salonId,
    this.serviceId,
    this.employeeId,
  });

  final int salonId;
  final int? serviceId;
  final int? employeeId;

  @override
  State<DateChoiceScreen> createState() => _DateChoiceScreenState();
}

class _DateChoiceScreenState extends State<DateChoiceScreen> {
  bool visible = false;
  bool expanded = false;

  DateTime _selectedDay = DateTime.now().subtract(const Duration(days: 1));
  DateTime _focusedDay = DateTime.now();

  late final TimetableBloc _timetableBloc;
  late final TimeblockBloc _timeblockBloc;

  @override
  void initState() {
    super.initState();
    _timetableBloc = TimetableBloc(
      repository: DependenciesScope.of(context).recordRepository,
    )..add(
        TimetableEvent.fetchTimetables(
          salonId: widget.salonId,
          serviceId: widget.serviceId,
          employeeId: widget.employeeId,
        ),
      );
    _timeblockBloc = TimeblockBloc(
      repository: DependenciesScope.of(context).recordRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat("LLLL y 'г.'");
    final formattedDate = formatter.format(now);

    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _timetableBloc),
          BlocProvider(create: (context) => _timeblockBloc),
        ],
        child: BlocBuilder<TimetableBloc, TimetableState>(
          builder: (context, state) => CustomScrollView(
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
              SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: state.hasTimetable
                        ? CustomTableCalendar(
                            focusedDay: _focusedDay,
                            onDaySelected: (selectedDay, focusedDay) =>
                                onDaySelected(
                                    selectedDay, focusedDay, state.timetables),
                            selectedDayPredicate: (day) =>
                                isSameDay(_selectedDay, day),
                            enabledDayPredicate: (day) =>
                                enabledDayPredicate(day, state.timetables),
                          )
                        : Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: context.colorScheme.background,
                              border: Border.all(
                                color: const Color(0xFF272727),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  formattedDate,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontFamily: FontFamily.geologica,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Shimmer(
                                  size: Size(double.infinity, 320),
                                  cornerRadius: 16,
                                ),
                              ],
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TimeblocksWrap(
                      dateAt: _selectedDay.jsonFormat(),
                      visible: visible,
                      expanded: expanded,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
    List<TimetableItem> timetableItems,
  ) {
    if (enabledDayPredicate(selectedDay, timetableItems)) {
      visible = true;
      expanded = !expanded;
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _timeblockBloc.add(
        TimeblockEvent.fetchTimeblocks(
          salonId: widget.salonId,
          serviceId: widget.serviceId,
          employeeId: widget.employeeId,
          dateAt: _selectedDay.jsonFormat(),
        ),
      );
    }
  }

  ///
  bool enabledDayPredicate(DateTime day, List<TimetableItem> timetables) {
    return day.isAfterAsNow()
        ? timetables.any(
            (timetable) =>
                timetable.dateAt.year == day.year &&
                timetable.dateAt.month == day.month &&
                timetable.dateAt.day == day.day,
          )
        : false;
  }
}
