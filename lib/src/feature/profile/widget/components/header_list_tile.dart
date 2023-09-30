import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/color_extension.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class HeaderListTile extends StatelessWidget {
  const HeaderListTile({super.key, this.onPressed, this.title});

  ///
  final String? title;

  ///
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.onBackground.lighten(0.04),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title ?? 'Настройте профиль',
          style: context.textTheme.headlineSmall?.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.secondary,
          ),
        ),
        subtitle: Text(
          '+7 (960) 487-53-29',
          style: context.textTheme.titleSmall?.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primary,
          ),
        ),
        trailing: AnimatedButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: ShapeDecoration(
              shape: const CircleBorder(
                side: BorderSide(color: Color(0xFF222222)),
              ),
              color: context.colorScheme.background,
            ),
            child: Icon(
              Icons.edit_rounded,
              color: context.colorScheme.secondary,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
