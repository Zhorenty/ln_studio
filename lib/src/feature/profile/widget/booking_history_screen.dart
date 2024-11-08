import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/widget/custom_snackbar.dart';
import 'package:ln_studio/src/common/widget/information_widget.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
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
        recordRepository: DependenciesScope.of(context).recordRepository,
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
          body: BlocConsumer<BookingHistoryBloc, BookingHistoryState>(
              listener: (context, state) => state.error != null
                  ? CustomSnackBar.showError(context, message: state.error)
                  : null,
              builder: (context, state) {
                return TabBarView(
                  children: [
                    _BookingList(
                      bookingHistory: state.upcomingEvents,
                      isUpcoming: true,
                    ),
                    _BookingList(
                      bookingHistory: state.pastEvents,
                      isUpcoming: false,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({
    required this.bookingHistory,
    required bool isUpcoming,
  }) : title = isUpcoming ? 'Предстоящих записей нет' : 'Прошедших записей нет';

  final List<BookingModel> bookingHistory;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      displacement: 16,
      onRefresh: () async => context.read<BookingHistoryBloc>().add(
            const BookingHistoryEvent.fetchAll(),
          ),
      child: bookingHistory.isNotEmpty
          ? ListView.builder(
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) =>
                  HistoryItemCard(bookingHistory[index]),
            )
          : InformationWidget.empty(
              title: title,
              description: null,
              reloadFunc: () => context.read<BookingHistoryBloc>().add(
                    const BookingHistoryEvent.fetchAll(),
                  ),
            ),
    );
  }
}
