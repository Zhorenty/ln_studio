import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
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
  });

  final EmployeeModel? employeePreset;

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
    employeesBloc = context.read<EmployeeBloc>();
    _fetchSalonEmployees();
    initController();
    selectedEmployee = widget.employeePreset;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBLoC, SalonState>(
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (previous.currentSalon?.id != current.currentSalon?.id) {
          employeesBloc.add(
            EmployeeEvent.fetchSalonEmployees(current.currentSalon!.id),
          );
        }
        return false;
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
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
                  if (state.hasEmployee) ...[
                    SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: SliverList.builder(
                        itemCount: state.employees.length,
                        itemBuilder: (context, index) {
                          final employee = state.employees[index];

                          return !employee.isDismiss
                              ? EmployeeCard(
                                  employee: employee,
                                  selectedEmployee: selectedEmployee,
                                  onChanged: (cardEmployee) => setState(() {
                                    visible = true;
                                    selectedEmployee = cardEmployee;
                                    context.goNamed(
                                      'record_from_employee_choice',
                                      extra: selectedEmployee,
                                    );
                                  }),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ] else ...[
                    const SkeletonEmployeeCard()
                  ],
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
                    'record_from_employee_choice',
                    extra: selectedEmployee,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        EmployeeEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
  }

  ///
  Future<void> _refresh() async {
    final block = context.read<EmployeeBloc>().stream.first;
    _fetchSalonEmployees();
    await block;
  }
}
