import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';

///
class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.visible, this.onPressed});

  ///
  final bool visible;

  ///
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: visible
          ? AnimatedButton(
              onPressed: onPressed,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: MediaQuery.sizeOf(context).width / 4,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Продолжить',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.onBackground,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
