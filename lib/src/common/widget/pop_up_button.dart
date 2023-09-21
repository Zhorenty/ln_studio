import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/overlay/modal_popup.dart';

/// Container with [ModalPopup.show] method.
class PopupButton extends StatelessWidget {
  const PopupButton({super.key, required this.child, this.label});

  /// Label of this [PopupButton].
  final Widget? label;

  /// Widget of this [PopupButton].
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => ModalPopup.show(context: context, child: child),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 + 4),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DefaultTextStyle(
            style: context.textTheme.titleMedium!.copyWith(
              fontSize: 17,
              color: context.colorScheme.onBackground,
              fontFamily: FontFamily.geologica,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null) label!,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colorScheme.onBackground,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      );
}
