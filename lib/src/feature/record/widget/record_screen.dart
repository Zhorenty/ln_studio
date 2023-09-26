import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_state.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';

///
class RecordScreen extends StatefulWidget {
  const RecordScreen({
    super.key,
    this.servicePreset,
    this.employeePreset,
    this.datePreset,
  });

  ///
  final ServiceModel? servicePreset;

  ///
  final EmployeeModel? employeePreset;

  ///
  final DateTime? datePreset;

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late final RecordBLoC recordBLoC;

  late final TextEditingController commentController;
  late final FocusNode commentFocusNode;

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

    commentController = TextEditingController();
    commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    commentController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: GestureDetector(
        onTap: () {
          if (commentFocusNode.hasFocus) {
            commentFocusNode.unfocus();
          }
        },
        child: CustomScrollView(
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
                            title: state.service?.name ?? 'Выберите услугу',
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
                          HugeTextField(
                            controller: commentController,
                            focusNode: commentFocusNode,
                          ),
                          state.service?.price != null
                              ? Text('Стоимость: ${state.service?.price} ₽')
                              : const SizedBox.shrink(),
                          const SizedBox(height: 16),
                          AnimatedButton(
                            onPressed: () =>
                                // TODO: Wait until asset from
                                //  CongratilationScreen is loaded.
                                // if (state.isSuccessful)
                                context.goNamed('congratulation'),
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
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

///
class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.title, this.onTap});

  ///
  final String title;

  /// Callback, called when the container is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, bottom: 12),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Large text field for comments.
class HugeTextField extends StatelessWidget {
  const HugeTextField({super.key, this.controller, this.focusNode});

  ///
  final TextEditingController? controller;

  ///
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: context.textTheme.bodyLarge!.copyWith(
            fontFamily: FontFamily.geologica,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.scrim,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.scrim,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
