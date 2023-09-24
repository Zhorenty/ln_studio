import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/common/widget/shimmer.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/widget/salon_choice_screen.dart';

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
          title: context.stringOf().employees,
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
          bottomChild: BlocBuilder<SalonBLoC, SalonState>(
            builder: (context, state) => PopupButton(
              label: state.currentSalon != null
                  ? Text(state.currentSalon!.name)
                  : Shimmer(backgroundColor: context.colorScheme.onBackground),
              child: SalonChoiceScreen(currentSalon: state.currentSalon),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  'Записаться',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(
                height: 105,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecordTypeCard(
                      icon: Icons.brush,
                      description: 'На услугу',
                      onTap: () => context.go('/home/choice_service'),
                    ),
                    RecordTypeCard(
                      icon: Icons.person,
                      description: 'К мастеру',
                      onTap: () => context.go('/home/choice_employee'),
                    ),
                    RecordTypeCard(
                      icon: Icons.cached,
                      description: 'Повторно',
                      onTap: () => context.go('/home/choice_date'),
                    ),
                    RecordTypeCard(
                      icon: Icons.home_work_rounded,
                      description: 'На дом',
                      onTap: () => context.go('/home/record'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  'Новости',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///
class RecordTypeCard extends StatelessWidget {
  const RecordTypeCard({super.key, this.icon, this.description, this.onTap});

  ///
  final IconData? icon;

  ///
  final String? description;

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: context.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 45, color: context.colorScheme.secondary),
            if (description != null)
              Text(
                description!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontFamily: FontFamily.geologica,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
