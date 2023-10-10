import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/feature/home/widget/components/product_card.dart';
import 'package:ln_studio/src/feature/salon/widget/current_salon_screen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import 'components/custom_header.dart';
import 'components/news_card.dart';
import 'components/record_type_card.dart';

/// {@template Home_screen}
/// Home screen.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro Home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalonBLoC, SalonState>(
      builder: (context, state) => CustomScrollView(
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
            bottomChild: IgnorePointer(
              ignoring: state.currentSalon == null,
              child: PopupButton(
                smoothAnimate: false,
                label: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state.currentSalon != null
                      ? Text(state.currentSalon!.address)
                      : const SizedBox(height: 26),
                ),
                child: CurrentSalonScreen(
                  pathName: 'home',
                  currentSalon: state.currentSalon,
                ),
              ),
            ),
          ),
          SliverList.list(
            children: [
              const CustomHeader(label: 'Записаться'),
              SizedBox(
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
              const CustomHeader(label: 'Магазин'),
              SizedBox(
                height: 250,
                width: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductCard(
                      title: 'Шампунь с маслом лаванды',
                      price: 2000,
                      padding: 4,
                      child: Assets.images.productShampoo.image(),
                    ),
                    ProductCard(
                      title: 'Бальзам для волос Estel HyperBeam',
                      price: 3200,
                      padding: 12,
                      child: Assets.images.productBalzam.image(),
                    ),
                    ProductCard(
                      title: 'Пудра для фиксации волос',
                      price: 1400,
                      padding: 8,
                      child: Assets.images.productPowder.image(),
                    ),
                    ProductCard(
                      title: 'Глина для укладки волос Golden Apple',
                      price: 2300,
                      padding: 0,
                      child: Assets.images.productClay.image(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ],
      ),
    );
  }
}
