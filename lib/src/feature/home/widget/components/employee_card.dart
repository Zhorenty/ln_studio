import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/avatar_widget.dart';
import '/src/common/widget/star_rating.dart';
import '/src/feature/record/model/employee.dart';

///
class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});

  ///
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    final user = employee.userModel;

    return AnimatedButton(
      onPressed: () => context.goNamed('employee_info', extra: employee),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarWidget(
              radius: 45,
              title: employee.fullName,
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 110,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                user.firstName,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Text(
              employee.jobModel.name,
              style: context.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.geologica,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 2),
            StarRating(size: 18.5, initialRating: employee.stars),
          ],
        ),
      ),
    );
  }
}
