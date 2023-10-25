import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_bloc.dart';
import 'package:ln_studio/src/feature/home/bloc/news/news_state.dart';

import 'package:ln_studio/src/feature/record/bloc/employee/employee_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_event.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_state.dart';
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
  Widget build(BuildContext context) {
    return BlocListener<SalonBLoC, SalonState>(
      listener: (context, state) {},
      listenWhen: (previous, current) {
        previous.currentSalon?.id != current.currentSalon?.id
            ? _fetchSalonEmployees()
            : null;

        return false;
      },
      child: BlocBuilder<SalonBLoC, SalonState>(
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
                const CustomHeader(label: 'Наши мастера'),
                SizedBox(
                  height: 192,
                  child: BlocBuilder<EmployeeBloc, EmployeeState>(
                    builder: (context, state) {
                      final employees = state.employees
                          .where((employee) => !employee.isDismiss)
                          .toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: employees.length,
                        itemBuilder: (context, index) => EmployeeCard(
                          employee: employees[index],
                        ),
                      );
                    },
                  ),
                ),
                const CustomHeader(label: 'Новости'),
                SizedBox(
                  height: 115,
                  child: BlocBuilder<NewsBLoC, NewsState>(
                    builder: (context, state) => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.news?.length,
                      itemBuilder: (context, index) => NewsCard(
                        label: state.news?[index].title,
                        asset: Assets.images.placeholder2.image(
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
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
}
