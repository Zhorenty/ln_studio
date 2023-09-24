import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/overlay/modal_popup.dart';

/// Container with [ModalPopup.show] method.
class PopupButton extends StatefulWidget {
  const PopupButton({super.key, required this.child, this.label});

  /// Label of this [PopupButton].
  final Widget? label;

  /// Widget of this [PopupButton].
  final Widget child;

  @override
  State<PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton>
    with TickerProviderStateMixin {
  /// Controller for an [ModalPopup.show] animation.
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ModalPopup.show(
        context: context,
        child: widget.child,
        transitionAnimationController: controller,
      ),
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
              if (widget.label != null) widget.label!,
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

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 1000);
    controller.reverseDuration = const Duration(milliseconds: 500);
  }
}
