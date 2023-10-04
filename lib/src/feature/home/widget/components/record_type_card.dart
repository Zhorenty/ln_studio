import 'package:flutter/material.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

///
class RecordTypeCard extends StatelessWidget {
  const RecordTypeCard({
    super.key,
    required this.image,
    this.description,
    this.onTap,
    this.ignoring = false,
  });

  ///
  final bool ignoring;

  ///
  final Image image;

  ///
  final String? description;

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignoring,
      child: AnimatedButton(
        onPressed: onTap,
        child: Container(
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: context.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF272727)),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !ignoring
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image,
                      const SizedBox(height: 4),
                      if (description != null)
                        Text(
                          description!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.secondary,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
