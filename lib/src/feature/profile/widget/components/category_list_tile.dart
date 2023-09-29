import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

///
class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.size = 22,
  });

  ///
  final IconData? icon;

  ///
  final double size;

  ///
  final String title;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(
        icon,
        size: size,
        color: context.colorScheme.primary,
      ),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontFamily: FontFamily.geologica,
          color: context.colorScheme.secondary,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: context.colorScheme.primaryContainer,
        size: 22,
      ),
    );
  }
}
