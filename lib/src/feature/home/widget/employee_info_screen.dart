import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/feature/home/widget/components/expanded_app_bar.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/salon/widget/current_salon_screen.dart';

///
class EmployeeInfoScreen extends StatefulWidget {
  const EmployeeInfoScreen({super.key, required this.employee});

  ///
  final EmployeeModel employee;

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  // Переменные, которые не должны изменяться при rebuild'е.
  // int? clientsCount;
  // int? workedDaysCount;

  @override
  Widget build(BuildContext context) {
    // if (clientsCount == null) {
    //   clientsCount = widget.employee.clients;
    //   workedDaysCount = widget.employee.workedDays;
    // }

    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ExpandedAppBar(
                label: widget.employee.fullName,
                title: Text(
                  widget.employee.fullName,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                leading: Text(
                  '0',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                trailing: Text(
                  '0',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  // TODO: Implement fetching by id.
                },
              ),
              SliverFillViewport(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Отзывы',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () => context.goNamed(
                  'record',
                  extra: widget.employee,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Записаться',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
