import 'package:flutter/material.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

///
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool notifications = false;

  bool hourNotification = false;
  bool dayNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Уведомления',
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 19,
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: [
                NotificationBlock(
                  title: 'Общие',
                  children: [
                    SwitcherRow(
                      label: 'Пуш-уведомления',
                      value: notifications,
                      onChanged: (_) => setState(
                        () => notifications = !notifications,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                NotificationBlock(
                  title: 'Напоминания о визите',
                  children: [
                    SwitcherRow(
                      label: 'За час до визита',
                      value: hourNotification,
                      onChanged: (value) {
                        hourNotification = !hourNotification;
                        setState(() {});
                      },
                    ),
                    SwitcherRow(
                      label: 'За день до визита',
                      value: dayNotification,
                      onChanged: (value) {
                        dayNotification = !dayNotification;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///
class NotificationBlock extends StatelessWidget {
  const NotificationBlock({
    super.key,
    required this.title,
    required this.children,
  });

  ///
  final String title;

  ///
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0XFF272727)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: 19,
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }
}

///
class SwitcherRow extends StatelessWidget {
  const SwitcherRow({
    super.key,
    required this.label,
    this.onChanged,
    this.value = false,
  });

  ///
  final bool value;

  ///
  final void Function(bool)? onChanged;

  ///
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.secondaryContainer,
            fontFamily: FontFamily.geologica,
            fontWeight: FontWeight.w300,
          ),
        ),
        Transform.scale(
          scale: .9,
          child: Switch(
            thumbColor: MaterialStatePropertyAll(context.colorScheme.secondary),
            inactiveTrackColor: const Color(0xFF3F3F3F),
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
