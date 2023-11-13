import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/widget/information_widget.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/feature/auth/widget/auth_scope.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_bloc.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_event.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_state.dart';
import 'package:ln_studio/src/feature/initialization/logic/initialization_steps.dart';

import 'package:ln_studio/src/feature/record/bloc/employee/employee_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_event.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_state.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_event.dart';
import 'package:ln_studio/src/feature/salon/widget/current_salon_screen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import 'components/custom_header.dart';
import 'components/employee_card.dart';
import 'components/news_card.dart';
import 'components/record_type_card.dart';

/// {@template Home_screen}
/// Home screen.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro Home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationScope.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<SalonBLoC, SalonState>(
          listener: (context, state) {},
          listenWhen: (previous, current) {
            previous.currentSalon?.id != current.currentSalon?.id
                ? _fetchSalonEmployees()
                : null;

            return false;
          },
        ),
      ],
      child: BlocBuilder<SalonBLoC, SalonState>(
        builder: (context, state) => CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title: 'Здравствуйте, ${auth.user?.firstName}',
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
              bottomChild: Builder(builder: (context) {
                if (state.hasError) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.sizeOf(context).width / 3,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ошибка'),
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded),
                          onPressed: () => context
                              .read<SalonBLoC>()
                              .add(const SalonEvent.fetchAll()),
                        ),
                      ],
                    ),
                  );
                } else if (state.isProcessing) {
                  return Shimmer(
                    size: Size(
                      MediaQuery.sizeOf(context).width / 1.3,
                      MediaQuery.sizeOf(context).width / 9,
                    ),
                  );
                }
                return IgnorePointer(
                  ignoring: state.currentSalon == null,
                  child: PopupButton(
                    smoothAnimate: false,
                    label: Text(state.currentSalon?.address ?? ''),
                    child: CurrentSalonScreen(
                      pathName: 'home',
                      currentSalon: state.currentSalon,
                    ),
                  ),
                );
              }),
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
                const CustomHeader(label: 'Наши мастера'),
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    final employees = state.employees
                        .where((employee) => !employee.isDismiss)
                        .toList();
                    if (state.hasError) {
                      return InformationWidget.error(
                        reloadFunc: _fetchSalonEmployees,
                      );
                    } else if (state.isProcessing) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Shimmer(
                          size: Size.fromHeight(
                            MediaQuery.sizeOf(context).height / 5.5,
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 192,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: employees.length,
                        itemBuilder: (context, index) => EmployeeCard(
                          employee: employees[index],
                        ),
                      ),
                    );
                  },
                ),
                const CustomHeader(label: 'Новости'),
                BlocBuilder<NewsBLoC, NewsState>(
                  builder: (context, state) {
                    final news =
                        state.news.where((news) => !news.isDeleted).toList();
                    if (state.hasError) {
                      return InformationWidget.error(
                        reloadFunc: _fetchNews,
                      );
                    } else if (state.isProcessing) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Shimmer(
                          size: Size.fromHeight(
                            MediaQuery.sizeOf(context).height / 5.5,
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 115,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: news.length,
                        itemBuilder: (context, index) => NewsCard(
                          onPressed: () => context.goNamed(
                            'news',
                            extra: news[index],
                          ),
                          label: news[index].title,
                          child: news[index].photo != null
                              ? CachedNetworkImage(
                                  imageUrl: '$kBaseUrl/${news[index].photo!}',
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => ColoredBox(
                                    color: context.colorScheme.onBackground,
                                    child: Assets.images.logoWhite.image(
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : Assets.images.logoWhite.image(
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _fetchSalonEmployees() {
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      context.read<EmployeeBloc>().add(
            EmployeeEvent.fetchEmployees(
              salonId: salonBloc.state.currentSalon!.id,
              serviceId: null,
              timeblockId: null,
              dateAt: null,
            ),
          );
    }
  }

  void _fetchNews() => context.read<NewsBLoC>().add(const NewsEvent.fetchAll());
}
