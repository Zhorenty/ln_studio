import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

///
class RecordTypeCard extends StatelessWidget {
  const RecordTypeCard({super.key, this.icon, this.description, this.onTap});

  ///
  final IconData? icon;

  ///
  final String? description;

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: context.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 45, color: context.colorScheme.secondary),
            if (description != null)
              Text(
                description!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontFamily: FontFamily.geologica,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
