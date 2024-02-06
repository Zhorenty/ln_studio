import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/custom_snackbar.dart';
import 'package:ln_studio/src/common/widget/information_widget.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_event.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_state.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/widget/components/continue_button.dart';
import 'package:ln_studio/src/feature/record/widget/components/employee_card.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_state.dart';

/// {@template Employees_screen}
/// Employees screen.
/// {@endtemplate}
class EmployeeChoiceScreen extends StatefulWidget {
  /// {@macro Employees_screen}
  const EmployeeChoiceScreen({
    super.key,
    this.employeePreset,
    required this.salonId,
    this.serviceId,
    this.timeblockId,
    this.dateAt,
  });

  ///
  final EmployeeModel? employeePreset;

  ///
  final int salonId;

  ///
  final int? serviceId;

  ///
  final int? timeblockId;

  ///
  final String? dateAt;

  @override
  State<EmployeeChoiceScreen> createState() => _EmployeeChoiceScreenState();
}

class _EmployeeChoiceScreenState extends State<EmployeeChoiceScreen>
    with TickerProviderStateMixin {
  /// Controller for an [ModalPopup.show] animation.
  late AnimationController controller;

  /// Employees bloc maintaining [EmployeeChoiceScreen] state.
  late final EmployeeBloc employeesBloc;

  ///
  EmployeeModel? selectedEmployee;

  ///
  bool visible = false;

  @override
  void initState() {
    super.initState();
    employeesBloc = EmployeeBloc(
      repository: DependenciesScope.of(context).recordRepository,
    );
    _fetchSalonEmployees();
    initController();
    selectedEmployee = widget.employeePreset;
  }

  @override
  void dispose() {
    employeesBloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<SalonBLoC, SalonState>(
        listener: (context, state) {},
        listenWhen: (previous, current) {
          if (previous.currentSalon?.id != current.currentSalon?.id) {
            employeesBloc.add(
              EmployeeEvent.fetchEmployees(
                salonId: widget.salonId,
                serviceId: widget.serviceId,
                timeblockId: widget.timeblockId,
                dateAt: widget.dateAt,
              ),
            );
          }
          return false;
        },
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          bloc: employeesBloc,
          listener: (context, state) {
            if (state.hasError) {
              CustomSnackBar.showError(context, message: state.error);
            }
          },
          builder: (context, state) => Scaffold(
            backgroundColor: context.colorScheme.onBackground,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        'Выберите мастера',
                        style: context.textTheme.titleLarge!.copyWith(
                          color: context.colorScheme.secondary,
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      centerTitle: true,
                      pinned: true,
                      actions: [
                        AnimatedButton(
                          padding: const EdgeInsets.only(right: 8 + 2, top: 2),
                          child: Icon(
                            Icons.person_search_rounded,
                            color: context.colorScheme.secondary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    CupertinoSliverRefreshControl(onRefresh: _refresh),
                    SliverAnimatedOpacity(
                      opacity: state.isProcessing ? .5 : 1,
                      duration: const Duration(milliseconds: 1000),
                      sliver: SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: state.hasEmployee
                            ? SliverList.builder(
                                itemCount: state.employees.length,
                                itemBuilder: (context, index) {
                                  final employee = state.employees[index];

                                  return !employee.isDismiss
                                      ? EmployeeCard(
                                          employee: employee,
                                          selectedEmployee: selectedEmployee,
                                          onChanged: (cardEmployee) =>
                                              setState(() {
                                            visible = true;
                                            selectedEmployee = cardEmployee;
                                            context.goNamed(
                                              'record',
                                              extra: {
                                                'employeePreset':
                                                    selectedEmployee,
                                              },
                                            );
                                          }),
                                        )
                                      : const SizedBox.shrink();
                                },
                              )
                            : state.isProcessing
                                ? SliverList.separated(
                                    itemCount: 5,
                                    itemBuilder: (context, index) =>
                                        const SkeletonEmployeeCard(),
                                    separatorBuilder: (c, i) =>
                                        const SizedBox(),
                                  )
                                : SliverToBoxAdapter(
                                    child: InformationWidget.empty(
                                      description:
                                          'Для выбранных параметров мастера отсутствуют',
                                    ),
                                  ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: visible
                          ? SizedBox(
                              height: MediaQuery.sizeOf(context).height / 9,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 20,
                  left: 0,
                  right: 0,
                  child: ContinueButton(
                    visible: visible,
                    onPressed: () => context.goNamed(
                      'record',
                      extra: {'employeePreset': selectedEmployee},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  ///
  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
    controller.reverseDuration = const Duration(milliseconds: 350);
  }

  ///
  void _fetchSalonEmployees() {
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      employeesBloc.add(
        EmployeeEvent.fetchEmployees(
          salonId: widget.salonId,
          serviceId: widget.serviceId,
          timeblockId: widget.timeblockId,
          dateAt: widget.dateAt,
        ),
      );
    }
  }

  ///
  Future<void> _refresh() async {
    final bloc = context.read<EmployeeBloc>().stream.first;
    _fetchSalonEmployees();
    await bloc;
  }
}

class SkeletonEmployeeCard extends StatelessWidget {
  const SkeletonEmployeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF272727),
        ),
      ),
      child: const Shimmer(
        size: Size(double.infinity, 95),
        cornerRadius: 16,
      ),
    );
  }
}
