import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// Animated message briefly displayed at the bottom of the screen.
///
/// Custom implementation of a default [SnackBar].
class FloatingSnackBar extends StatefulWidget {
  const FloatingSnackBar({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.onEnd,
    this.bottom = 16,
  });

  /// Content to display in this [FloatingSnackBar].
  final Widget child;

  /// [Duration] to display this [FloatingSnackBar] for.
  final Duration duration;

  /// Callback, called when this [FloatingSnackBar] disappears.
  final VoidCallback? onEnd;

  /// Bottom margin to apply to this [FloatingSnackBar].
  final double bottom;

  /// Displays a [FloatingSnackBar] in a [Overlay] with the provided [title].
  static void show(BuildContext context, String title, {double bottom = 16}) {
    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (_) => FloatingSnackBar(
        onEnd: () {
          if (entry?.mounted == true) {
            entry?.remove();
          }
          entry = null;
        },
        bottom: bottom,
        child: Text(title, style: context.textTheme.titleMedium),
      ),
    );

    Overlay.of(context).insert(entry!);
  }

  @override
  State<FloatingSnackBar> createState() => _FloatingSnackBarState();
}

/// State of a [FloatingSnackBar] maintaining the [_opacity].
class _FloatingSnackBarState extends State<FloatingSnackBar>
    with SingleTickerProviderStateMixin {
  /// Initial opacity of the [FloatingSnackBar].
  static const double _initialOpacity = 0;

  /// Final opacity of the [FloatingSnackBar].
  static const double _finalOpacity = 1;

  /// Current opacity of the [FloatingSnackBar].
  double _opacity = _initialOpacity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _opacity = _finalOpacity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: widget.bottom,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: GestureDetector(
              onTap: () => setState(() => _opacity = _initialOpacity),
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 120),
                onEnd: _onEnd,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: context.colorScheme.onBackground,
                    border: Border.all(
                      color: context.colorScheme.primary.withOpacity(.25),
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.background.withOpacity(.20),
                        blurRadius: 8,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Changes the [_opacity] after some delay to the [_initialOpacity] and
  /// invokes the [FloatingSnackBar.onEnd] afterwards.
  Future<void> _onEnd() async {
    if (_opacity == _finalOpacity) {
      await Future.delayed(widget.duration, () {
        if (mounted) {
          setState(() => _opacity = _initialOpacity);
        }
      });
    } else if (_opacity == _initialOpacity) {
      widget.onEnd?.call();
    }
  }
}
