import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';

/// {@template timetable_skeleton}
/// TimetableSkeleton widget.
/// {@endtemplate}
class TimetableSkeleton extends StatelessWidget {
  /// {@macro timetable_skeleton}
  const TimetableSkeleton({
    super.key,
    required this.formattedDate,
  });

  final String formattedDate;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              formattedDate,
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
            const SizedBox(height: 8),
            const Shimmer(
              size: Size(double.infinity, 320),
              cornerRadius: 16,
            ),
          ],
        ),
      );
}
