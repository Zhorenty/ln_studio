import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/feature/home/widget/components/news_card.dart';
import 'package:ln_studio/src/feature/salon/widget/current_salon_screen.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
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
          title: 'Здравствуйте, Евгений',
          actions: [
            AnimatedButton(
              padding: const EdgeInsets.only(right: 8 + 2, bottom: 2),
              child: Icon(
                Icons.notifications_rounded,
                color: context.colorScheme.secondary,
              ),
              onPressed: () {},
            ),
          ],
          bottomChild: BlocBuilder<SalonBLoC, SalonState>(
            builder: (context, state) => IgnorePointer(
              ignoring: state.currentSalon == null,
              child: PopupButton(
                smoothAnimate: false,
                label: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state.currentSalon != null
                      ? Text(state.currentSalon!.address)
                      : const SizedBox(height: 26),
                ),
                child: CurrentSalonScreen(currentSalon: state.currentSalon),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(label: 'Записаться'),
              BlocBuilder<SalonBLoC, SalonState>(builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state.currentSalon == null ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        RecordTypeCard(
                          ignoring: state.currentSalon == null,
                          image: Assets.images.serviceIcon.image(scale: 10),
                          description: 'На услугу',
                          onTap: () => context.goNamed(
                            'choice_service',
                            queryParameters: {
                              'salon_id': state.currentSalon!.id.toString(),
                            },
                          ),
                        ),
                        RecordTypeCard(
                          ignoring: state.currentSalon == null,
                          image: Assets.images.employeeIcon.image(scale: 10),
                          description: 'К мастеру',
                          onTap: () => context.goNamed(
                            'choice_employee',
                            queryParameters: {
                              'salon_id': state.currentSalon!.id.toString(),
                            },
                          ),
                        ),
                        RecordTypeCard(
                          ignoring: state.currentSalon == null,
                          image: Assets.images.calendarIcon.image(scale: 10),
                          description: 'На дату',
                          onTap: () => context.goNamed(
                            'choice_date',
                            queryParameters: {
                              'salon_id': state.currentSalon!.id.toString(),
                            },
                          ),
                        ),
                        RecordTypeCard(
                          ignoring: state.currentSalon == null,
                          image: Assets.images.repeatIcon.image(scale: 10),
                          description: 'Повторно',
                          onTap: () => context.goNamed(
                            'record',
                            queryParameters: {
                              'salon_id': state.currentSalon!.id.toString(),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const CustomHeader(label: 'Новости'),
              SizedBox(
                height: 115,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    NewsCard(
                      label: 'Секреты маникюра\nв ЛН Студии',
                      asset: Assets.images.placeholder2.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    NewsCard(
                      label: 'Осенний уход за волосами',
                      asset: Assets.images.placeholder.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    NewsCard(
                      label: 'Макияж как искусство:\nтехники и трюки',
                      asset: Assets.images.placeholder31.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                    NewsCard(
                      label: 'Важность посещения салона для мужчин',
                      asset: Assets.images.placeholder4.image(
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              // const CustomHeader(label: 'Магазин'),
            ],
          ),
        ),
      ],
    );
  }
}

///
class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.label});

  ///
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.secondary,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: context.colorScheme.primary,
            ),
            height: 3.3,
            width: 50,
          ),
        ],
      ),
    );
  }
}
