import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_state.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({
    super.key,
    this.servicePreset,
    this.employeePreset,
    this.datePreset,
  });

  final ServiceModel? servicePreset;
  final EmployeeModel? employeePreset;
  final DateTime? datePreset;

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late final RecordBLoC recordBLoC;

  @override
  void initState() {
    super.initState();
    recordBLoC = RecordBLoC(
      initialState: RecordState$Idle(
        service: widget.servicePreset,
        employee: widget.employeePreset,
        date: widget.datePreset,
        salon: null,
        timetableItem: null,
        comment: null,
      ),
      repository: DependenciesScope.of(context).recordRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'Запись на маникюр',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: DefaultTextStyle(
                style: context.textTheme.titleMedium!.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
                child: BlocBuilder<RecordBLoC, RecordState>(
                    bloc: recordBLoC,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Выберите услугу'),
                          CustomContainer(
                            title: state.service?.name ?? 'Выберите услуг',
                            onTap: () => context.goNamed(
                              'choice_service_from_record',
                              extra: state.service,
                            ),
                          ),
                          const Text('Выберите мастера'),
                          CustomContainer(
                            title:
                                state.employee?.fullName ?? 'Выберите мастера',
                            onTap: () => context.goNamed(
                              'choice_employee_from_record',
                              extra: state.employee,
                            ),
                          ),
                          const Text('Выберите дату и время'),
                          CustomContainer(
                            title: 'Выберите дату и время',
                            onTap: () => context.goNamed(
                              'choice_date_from_record',
                              extra: state.date,
                              // TODO: Передавать реальный id
                              pathParameters: {'employee_id': '3'},
                            ),
                          ),
                          const Text('Филиал'),
                          CustomContainer(
                            title: context
                                    .read<SalonBLoC>()
                                    .state
                                    .currentSalon
                                    ?.name ??
                                'Выберите филиал на главном экране',
                          ),
                          const Text('Комментарий к записи'),
                          const HugeTextField(),
                          const Text('Стоимость: 1 700 000 ₽'),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 32 + 16,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Записаться',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

///
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        margin: const EdgeInsets.only(top: 10, bottom: 12),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
            const AnimatedButton(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

/// Large text field for comments.
class HugeTextField extends StatelessWidget {
  const HugeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF272727)),
      ),
    );
  }
}
