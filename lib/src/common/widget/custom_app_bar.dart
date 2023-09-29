import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// Custom-styled [SliverAppBar].
class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    required this.bottomChild,
    this.actions = const <Widget>[],
    this.centerTitle = false,
  });

  final bool centerTitle;

  /// Primary widget displayed in the [CustomSliverAppBar].
  final String? title;

  /// List of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  ///
  final Widget? bottomChild;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: centerTitle,
      title: title != null
          ? Text(
              title!,
              style: context.textTheme.titleLarge!.copyWith(
                color: context.colorScheme.secondary,
                fontFamily: FontFamily.geologica,
              ),
            )
          : null,
      actions: actions,
      floating: true,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size(300, 62),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: bottomChild,
        ),
      ),
    );
  }
}
