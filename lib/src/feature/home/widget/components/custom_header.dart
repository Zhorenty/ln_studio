import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

///
class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.label});

  ///
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyLarge?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.secondary,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: context.colorScheme.primary,
            ),
            height: 3.3,
            width: 50,
          ),
        ],
      ),
    );
  }
}
