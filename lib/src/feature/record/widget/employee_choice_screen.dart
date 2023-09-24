import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';
import 'package:ln_studio/src/common/widget/custom_app_bar.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_studio/src/common/widget/pop_up_button.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/common/widget/star_rating.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_event.dart';
import 'package:ln_studio/src/feature/record/bloc/employee/employee_state.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_state.dart';
import 'package:ln_studio/src/feature/salon/widget/salon_choice_screen.dart';

/// {@template Employees_screen}
/// Employees screen.
/// {@endtemplate}
class EmployeeChoiceScreen extends StatefulWidget {
  /// {@macro Employees_screen}
  const EmployeeChoiceScreen({super.key});

  @override
  State<EmployeeChoiceScreen> createState() => _EmployeeChoiceScreenState();
}

class _EmployeeChoiceScreenState extends State<EmployeeChoiceScreen>
    with TickerProviderStateMixin {
  /// Controller for an [ModalPopup.show] animation.
  late AnimationController controller;

  /// Employees bloc maintaining [EmployeeChoiceScreen] state.
  late final EmployeeBloc employeesBloc;

  EmployeeModel? selectedEmployee;

  @override
  void initState() {
    super.initState();
    employeesBloc = context.read<EmployeeBloc>();
    _fetchSalonEmployees();
    initController();
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
          body: CustomScrollView(
            slivers: [
              CustomSliverAppBar(
                title: context.stringOf().employees,
                actions: [
                  AnimatedButton(
                    padding: const EdgeInsets.only(right: 8 + 2, top: 2),
                    child: Icon(
                      Icons.person_search_rounded,
                      color: context.colorScheme.primary,
                    ),
                    onPressed: () {},
                  ),
                ],
                bottomChild: BlocBuilder<SalonBLoC, SalonState>(
                  builder: (context, state) => PopupButton(
                    label: state.currentSalon != null
                        ? Text(state.currentSalon!.name)
                        : Shimmer(
                            backgroundColor: context.colorScheme.onBackground,
                          ),
                    child: SalonChoiceScreen(currentSalon: state.currentSalon),
                  ),
                ),
              ),
              CupertinoSliverRefreshControl(onRefresh: _refresh),
              if (state.hasEmployee) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverList.builder(
                    itemCount: state.employees.length,
                    itemBuilder: (context, index) {
                      final employee = state.employees[index];

                      if (employee.isDismiss == false) {
                        return EmployeeCard(
                          employee: employee,
                          selectedEmployee: selectedEmployee,
                          onChanged: (cardEmployee) =>
                              setState(() => selectedEmployee = cardEmployee),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ] else
                SliverToBoxAdapter(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.plus_one_rounded),
                    label: Text(
                      context.stringOf().addEmployee,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontFamily: FontFamily.geologica,
                        color: context.colorScheme.background,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: context.colorScheme.primary,
            label: Text(
              'Далее',
              style: context.textTheme.bodySmall!.copyWith(
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.background,
              ),
            ),
            onPressed: () => context.goNamed(
              'record_from_employee_choice',
              extra: selectedEmployee,
            ),
          ),
        ),
      ),
    );
  }

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 700);
    controller.reverseDuration = const Duration(milliseconds: 350);
  }

  void _fetchSalonEmployees() {
    final salonBloc = context.read<SalonBLoC>();
    if (salonBloc.state.currentSalon != null) {
      employeesBloc.add(
        EmployeeEvent.fetchSalonEmployees(salonBloc.state.currentSalon!.id),
      );
    }
  }

  Future<void> _refresh() async {
    final block = context.read<EmployeeBloc>().stream.first;
    _fetchSalonEmployees();
    await block;
  }
}

///
class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.selectedEmployee,
    required this.onChanged,
  });

  ///
  final EmployeeModel employee;

  final EmployeeModel? selectedEmployee;

  final void Function(EmployeeModel?) onChanged;

  @override
  Widget build(BuildContext context) {
    final user = employee.userModel;
    final jobPlace = employee.jobModel;
    return GestureDetector(
      onTap: () => onChanged(employee),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AvatarWidget(
              radius: 40,
              title: '${user.firstName} ${user.lastName}',
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    jobPlace.name,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StarRating(initialRating: employee.stars)
                ],
              ),
            ),
            Radio<EmployeeModel>(
              value: employee,
              groupValue: selectedEmployee,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
