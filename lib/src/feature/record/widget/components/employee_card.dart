import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/color_extension.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';
import 'package:ln_studio/src/common/widget/star_rating.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';

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

  ///
  final EmployeeModel? selectedEmployee;

  ///
  final void Function(EmployeeModel?) onChanged;

  @override
  Widget build(BuildContext context) {
    final user = employee.userModel;
    final jobPlace = employee.jobModel;
    return AnimatedButton(
      onPressed: () => onChanged(employee),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.background.lighten(0.015),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF272727)),
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
                  IgnorePointer(
                    child: StarRating(initialRating: employee.stars),
                  )
                ],
              ),
            ),
            const AnimatedButton(
              child: Icon(Icons.info_outline_rounded),
              // onPressed: () => _gotoDetailsPage(context, user),
            ),
            Visibility(
              visible: false,
              child: Radio<EmployeeModel>(
                value: employee,
                groupValue: selectedEmployee,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
