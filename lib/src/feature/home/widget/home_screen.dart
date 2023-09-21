import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/custom_app_bar.dart';
import 'package:ln_studio/src/common/widget/pop_up_button.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// {@template Home_screen}
/// Home screen.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro Home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: 'Привет, Хищник',
          actions: [
            AnimatedButton(
              padding: const EdgeInsets.only(right: 8 + 2, top: 2),
              child: Icon(
                Icons.notifications_rounded,
                color: context.colorScheme.primary,
              ),
              onPressed: () {},
            ),
          ],
          bottomChild: PopupButton(
            label: const Text('Тут салон'),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(''),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            context.stringOf().employees,
            style: context.textTheme.titleMedium?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
