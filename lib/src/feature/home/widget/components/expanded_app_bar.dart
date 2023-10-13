import 'package:flutter/material.dart';

import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';
import 'package:ln_studio/src/common/widget/overlay/message_popup.dart';

/// Custom-styled expanded [SliverAppBar].
class ExpandedAppBar extends StatelessWidget {
  const ExpandedAppBar({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    this.label,
    this.additionalTrailing = const <Widget>[],
    this.onExit,
  });

  ///
  final String? label;

  /// Primary widget displayed in the app bar under the [CircleAvatar].
  final Widget title;

  /// Leading widget of this [ExpandedAppBar].
  final Widget leading;

  /// Trailing widget of this [ExpandedAppBar].
  final Widget trailing;

  /// Additional trailing widgets.
  final List<Widget> additionalTrailing;

  /// Callback, called when icon is pressed.
  final void Function()? onExit;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.colorScheme.background,
      surfaceTintColor: context.colorScheme.background,
      toolbarHeight: 130,
      centerTitle: true,
      title: AvatarWidget(radius: 60, title: label),
      floating: true,
      pinned: true,
      leading: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          padding: const EdgeInsets.only(top: 28),
          onPressed: onExit,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: context.colorScheme.secondary,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: IconButton(
            icon: Icon(
              Icons.more_horiz_rounded,
              color: context.colorScheme.secondary,
            ),
            highlightColor: context.colorScheme.scrim,
            onPressed: () => MessagePopup.bottomSheet(
              context,
              // scrolled: false,
              'Действия с сотрудником',
              additional: additionalTrailing,
            ),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size(300, 48),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: title,
        ),
      ),
    );
  }
}
