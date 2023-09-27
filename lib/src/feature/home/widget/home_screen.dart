import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/feature/salon/widget/current_salon_screen.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/common/widget/shimmer.dart';
import '/src/feature/home/widget/components/record_type_card.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';

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
              smoothAnimate: false,
              label: state.currentSalon != null
                  ? Text(state.currentSalon!.name)
                  : Shimmer(backgroundColor: context.colorScheme.onBackground),
              // child: SalonChoiceScreen(currentSalon: state.currentSalon),
              child: CurrentSalonScreen(currentSalon: state.currentSalon),
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
              SizedBox(
                height: 115,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    NewsCard(
                      label: 'Осенний уход за волосами',
                      asset: Assets.images.placeholder1.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    NewsCard(
                      label: 'Осенний\nуход за кожей',
                      asset: Assets.images.congrats.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    NewsCard(
                      label: '',
                      asset: Assets.images.congrats.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    NewsCard(
                      label: '',
                      asset: Assets.images.congrats.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  'Магазин',
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

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.asset, this.label});

  final Image? asset;

  final String? label;

  @override
  Widget build(BuildContext context) {
    const double width = 175;

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: asset,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: width - 15,
                  child: Text(
                    label ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
