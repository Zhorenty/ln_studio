import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// [WidgetButton] animating its size on hover and clicks.
class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.child,
    this.decorator = AnimatedButton._defaultDecorator,
    this.onPressed,
    this.enabled = true,
    this.padding = EdgeInsets.zero,
  });

  /// Multiplier to scale the [child] on hover.
  static const double scale = 1.05;

  /// Widget to animate.
  final Widget child;

  /// Padding of this [AnimatedButton].
  final EdgeInsetsGeometry padding;

  /// Callback, applying non-animated decorations to the [child].
  final Widget Function(Widget child) decorator;

  /// Callback, called when the [child] is pressed.
  final void Function()? onPressed;

  /// Indicator whether the animation is enabled.
  final bool enabled;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();

  /// Returns the [child].
  ///
  /// Intended to be used as a default of the [decorator].
  static Widget _defaultDecorator(Widget child) => child;
}

/// State of the [AnimatedButton] maintaining the animation.
class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  /// [AnimationController] controlling the animation.
  late AnimationController _controller;

  /// Indicator whether this [AnimatedButton] is hovered.
  bool _hovered = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 300),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.decorator(widget.child);
    }

    return MouseRegion(
      opaque: false,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          if (event.buttons == kPrimaryMouseButton) {
            _controller.reset();
            _controller.forward();
          }
        },
        child: Padding(
          padding: widget.padding,
          child: WidgetButton(
            onPressed: widget.onPressed,
            child: widget.decorator(
              AnimatedScale(
                duration: const Duration(milliseconds: 100),
                scale: _hovered ? AnimatedButton.scale : 1,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: 1.0 -
                          Tween<double>(begin: 0.0, end: 0.2)
                              .animate(
                                CurvedAnimation(
                                  parent: _controller,
                                  curve: const Interval(
                                    0.0,
                                    1.0,
                                    curve: Curves.ease,
                                  ),
                                ),
                              )
                              .value +
                          Tween<double>(begin: 0.0, end: 0.2)
                              .animate(
                                CurvedAnimation(
                                  parent: _controller,
                                  curve: const Interval(
                                    0.5,
                                    1.0,
                                    curve: Curves.ease,
                                  ),
                                ),
                              )
                              .value,
                      child: child,
                    );
                  },
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
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
