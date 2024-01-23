import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// Stylized modal popup.
///
/// Intended to be displayed with the [show] method.
abstract class ModalPopup {
  /// Returns a padding that should be applied to the elements inside a
  /// [ModalPopup].
  static EdgeInsets padding(BuildContext context) =>
      const EdgeInsets.symmetric(horizontal: 30);

  /// Opens a new [ModalPopup] wrapping the provided [child].
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    BoxConstraints desktopConstraints = const BoxConstraints(
      maxWidth: double.infinity,
      maxHeight: double.infinity,
    ),
    AnimationController? transitionAnimationController,
    BoxConstraints modalConstraints = const BoxConstraints(maxWidth: 380),
    BoxConstraints mobileConstraints = const BoxConstraints(
      maxWidth: double.infinity,
      maxHeight: double.infinity,
    ),
    EdgeInsets mobilePadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    EdgeInsets desktopPadding = const EdgeInsets.all(10),
    bool isDismissible = true,
    bool showDivider = true,
    bool useRootNavigator = true,
  }) {
    if (!kIsWeb) {
      return showModalBottomSheet(
        useRootNavigator: useRootNavigator,
        context: context,
        transitionAnimationController: transitionAnimationController,
        barrierColor: context.colorScheme.background.withOpacity(.5),
        isScrollControlled: true,
        backgroundColor: const Color.fromRGBO(14, 15, 17, 1),
        isDismissible: isDismissible,
        enableDrag: isDismissible,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 60,
        ),
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              if (isDismissible && showDivider) ...[
                Center(
                  child: Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Flexible(
                child: Padding(
                  padding: mobilePadding,
                  child: ConstrainedBox(
                    constraints: mobileConstraints,
                    child: child,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    } else {
      return showDialog(
        context: context,
        barrierColor: context.colorScheme.secondaryContainer,
        barrierDismissible: isDismissible,
        builder: (context) {
          return Center(
            child: Container(
              constraints: modalConstraints,
              width: modalConstraints.maxWidth,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: desktopPadding,
              decoration: BoxDecoration(
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ConstrainedBox(
                constraints: desktopConstraints,
                child: child,
              ),
            ),
          );
        },
      );
    }
  }
}

/// [Row] with [text] and [WidgetButton] stylized to be a [ModalPopup] header.
class ModalPopupHeader extends StatelessWidget {
  const ModalPopupHeader({
    super.key,
    this.text,
    this.onBack,
    this.close = true,
  });

  /// Text to display as a title of this [ModalPopupHeader].
  final String? text;

  /// Callback, called when a back button is pressed.
  ///
  /// If `null`, then no back button is displayed at all.
  final void Function()? onBack;

  /// Indicator whether a close button should be displayed.
  final bool close;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Row(
        children: [
          if (onBack != null)
            WidgetButton(
              onPressed: onBack,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 14,
                  color: context.colorScheme.primary,
                ),
              ),
            )
          else
            const SizedBox(width: 40),
          if (text != null)
            Expanded(
              child: Center(
                child: Text(text!, style: context.textTheme.titleLarge),
              ),
            )
          else
            const Spacer(),
          if (kIsWeb && close)
            WidgetButton(
              onPressed: Navigator.of(context).pop,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: context.colorScheme.primary,
                ),
              ),
            )
          else
            const SizedBox(width: 40),
        ],
      ),
    );
  }
}

/// Simple [GestureDetector]-based button without any decorations.
class WidgetButton extends StatelessWidget {
  const WidgetButton({
    super.key,
    required this.child,
    this.behavior,
    this.onPressed,
  });

  /// [Widget] to press.
  final Widget child;

  /// [HitTestBehavior] of this [WidgetButton].
  final HitTestBehavior? behavior;

  /// Callback, called when the [child] is pressed.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onPressed == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        behavior: behavior,
        child: Container(
          color: context.colorScheme.scrim,
          child: child,
        ),
      ),
    );
  }
}
