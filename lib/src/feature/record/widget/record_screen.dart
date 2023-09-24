import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({
    super.key,
    this.servicePreset,
    this.employeePreset,
  });

  final ServiceModel? servicePreset;
  final EmployeeModel? employeePreset;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Выберите услугу'),
                    CustomContainer(
                      title: servicePreset?.name ?? 'Выберите услуг',
                    ),
                    const Text('Выберите мастера'),
                    CustomContainer(
                      title: employeePreset?.fullName ?? 'Выберите мастера',
                    ),
                    const Text('Выберите дату и время'),
                    const CustomContainer(
                      title: 'Выберите дату и время',
                    ),
                    const Text('Филиал'),
                    CustomContainer(
                      title:
                          context.read<SalonBLoC>().state.currentSalon?.name ??
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
                ),
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
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
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
