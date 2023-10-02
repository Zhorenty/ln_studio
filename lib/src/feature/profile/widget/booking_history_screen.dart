import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/extensions/date_time_extension.dart';
import '/src/feature/initialization/widget/dependencies_scope.dart';
import '/src/feature/profile/bloc/booking_history/booking_history_bloc.dart';
import '/src/feature/profile/bloc/booking_history/booking_history_event.dart';
import '/src/feature/profile/bloc/booking_history/booking_history_state.dart';
import 'components/history_item_card.dart';

///
class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingHistoryBloc(
        repository: DependenciesScope.of(context).profileRepository,
      )..add(const BookingHistoryEvent.fetchAll()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: context.colorScheme.onBackground,
          appBar: AppBar(
            title: Text(
              'Мои записи',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16).add(
                  const EdgeInsets.only(bottom: 8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: context.colorScheme.background,
                  border: Border.all(color: const Color(0xFF272727)),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: context.colorScheme.onBackground,
                  labelColor: context.colorScheme.onBackground,
                  unselectedLabelColor: context.colorScheme.secondary,
                  labelStyle: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                  unselectedLabelStyle: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                  tabAlignment: TabAlignment.fill,
                  overlayColor: MaterialStatePropertyAll(
                    context.colorScheme.scrim,
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.colorScheme.primary,
                  ),
                  tabs: const [
                    Tab(text: 'Предстоящие'),
                    Tab(text: 'Прошедшие'),
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<BookingHistoryBloc, BookingHistoryState>(
              builder: (context, state) {
            return TabBarView(
              children: [
                ListView(
                  children: [
                    ...state.bookingHistory.reversed.map((e) {
                      if (!_isAfter(
                        e.dateAt.jsonFormat(),
                        e.timeblock.time,
                      )) {
                        return HistoryItemCard(
                          title: e.employee.fullName,
                          subtitle: e.service.name,
                          dateAt: e.dateAt.defaultFormat(),
                          timeblock: e.timeblock.time
                              .substring(0, e.timeblock.time.length - 3),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
                ListView(
                  children: [
                    ...state.bookingHistory.reversed.map(
                      (e) {
                        if (_isAfter(
                          e.dateAt.jsonFormat(),
                          e.timeblock.time,
                        )) {
                          return HistoryItemCard(
                            title: e.employee.fullName,
                            subtitle: e.service.name,
                            dateAt: e.dateAt.defaultFormat(),
                            timeblock: createTimeWithDuration(
                              e.timeblock.time,
                              20,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  ///
  String createTimeWithDuration(String serverTime, int duration) {
    DateTime parsedTime = DateTime.parse('2022-01-01 $serverTime');
    DateTime endTime = parsedTime.add(Duration(minutes: duration));

    String formattedStartTime =
        '${parsedTime.hour}:${parsedTime.minute.toString().padLeft(2, '0')}:${parsedTime.second.toString().padLeft(2, '0')}';
    String formattedEndTime =
        '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}:${endTime.second.toString().padLeft(2, '0')}';

    return '${formattedStartTime.substring(0, formattedStartTime.length - 3)} - ${formattedEndTime.substring(0, formattedEndTime.length - 3)}';
  }

  ///
  bool _isAfter(String dateAt, String timeblock) {
    // Разделяем значение timeblock на отдельные части
    List<String> timeblockParts = timeblock.split(':');
    int hours = int.parse(timeblockParts[0]);
    int minutes = int.parse(timeblockParts[1]);
    int seconds = int.parse(timeblockParts[2]);

    // Создаем объект DateTime для dateAt и timeblock
    DateTime dateAtDateTime = DateTime.parse(dateAt);
    DateTime timeblockDateTime = DateTime(dateAtDateTime.year,
        dateAtDateTime.month, dateAtDateTime.day, hours, minutes, seconds);

    // Сравниваем даты
    DateTime now = DateTime.now();
    if (now.isAfter(timeblockDateTime)) {
      return true;
    } else {
      return false;
    }
  }
}
