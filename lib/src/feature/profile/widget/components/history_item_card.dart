import 'package:flutter/material.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';

///
class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateAt,
    required this.timeblock,
  });

  ///
  final String title;

  ///
  final String subtitle;

  ///
  final String dateAt;

  ///
  final String timeblock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(radius: 25, title: title),
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
              // const Spacer(),
              // AnimatedButton(
              //   padding: const EdgeInsets.only(bottom: 24),
              //   child: Icon(
              //     Icons.more_vert_rounded,
              //     size: 20,
              //     color: context.colorScheme.secondary,
              //   ),
              // ),
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
          )
        ],
      ),
    );
  }
}
