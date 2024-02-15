import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';
import 'package:ln_studio/src/feature/profile/bloc/booking_history/booking_history_bloc.dart';
import 'package:ln_studio/src/feature/profile/bloc/booking_history/booking_history_event.dart';
import 'package:ln_studio/src/feature/profile/model/booking.dart';

///
String _createTimeWithDuration(String serverTime, int duration) {
  DateTime parsedTime = DateTime.parse('2022-01-01 $serverTime');
  DateTime endTime = parsedTime.add(Duration(minutes: duration));

  String formattedStartTime =
      '${parsedTime.hour}:${parsedTime.minute.toString().padLeft(2, '0')}:${parsedTime.second.toString().padLeft(2, '0')}';
  String formattedEndTime =
      '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}:${endTime.second.toString().padLeft(2, '0')}';

  return '${formattedStartTime.substring(0, formattedStartTime.length - 3)} - ${formattedEndTime.substring(0, formattedEndTime.length - 3)}';
}

///
class HistoryItemCard extends StatelessWidget {
  HistoryItemCard(this.booking, {super.key})
      : title = booking.employee.fullName,
        subtitle = booking.service.name,
        dateAt = booking.dateAt.defaultFormat(),
        timeblock = _createTimeWithDuration(
          booking.timeblock.time,
          booking.service.duration!,
        );

  ///
  final String title;

  ///
  final String subtitle;

  ///
  final String dateAt;

  ///
  final String timeblock;

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(radius: 26, title: title),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: context.colorScheme.secondary,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      color: context.colorScheme.primaryContainer,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Color(0xFF272727)),
          Text(
            'Дата записи:',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              color: context.colorScheme.secondary,
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$timeblock, $dateAt',
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.secondary,
              fontFamily: FontFamily.geologica,
            ),
          ),
          if (!booking.isDone && !booking.isCanceled) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                FilledButton(
                  onPressed: () {
                    context.goNamed(
                      'record',
                      extra: {
                        'recordId': booking.id,
                        'servicePreset': booking.service,
                        'employeePreset': booking.employee,
                      },
                    );
                  },
                  child: const Text('Перенести'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => context.read<BookingHistoryBloc>().add(
                        BookingHistoryEvent.cancelBooking(booking.id),
                      ),
                  child: Text(
                    'Отменить',
                    style: TextStyle(color: context.colorScheme.error),
                  ),
                ),
              ],
            ),
          ],
          if (booking.isCanceled) ...[
            const SizedBox(height: 4),
            Text(
              'Отменено',
              style: TextStyle(color: context.colorScheme.error, fontSize: 18),
            ),
          ],
          if (kDebugMode) ...[
            const SizedBox(height: 8),
            const Text(
              'Debug:',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 2),
            Text('ID: ${booking.id}'),
            const SizedBox(height: 2),
            Text('isDone: ${booking.isDone}'),
            const SizedBox(height: 2),
            Text('isCanceled: ${booking.isCanceled}'),
          ],
        ],
      ),
    );
  }
}
