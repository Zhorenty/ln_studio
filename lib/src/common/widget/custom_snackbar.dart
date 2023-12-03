import 'package:flutter/material.dart';

class CustomSnackBar {
  const CustomSnackBar._();

  static void showError(
    BuildContext context, {
    IconData icon = Icons.error_rounded,
    String? title,
    String? message,
  }) =>
      _show(
        context: context,
        icon: icon,
        iconColor: Theme.of(context).colorScheme.error,
        title: title ?? 'Ошибка',
        message: message ?? 'Попробовать снова',
      );

  static void showSuccessful(
    BuildContext context, {
    IconData icon = Icons.done_rounded,
    String? title,
    String? message,
  }) =>
      _show(
        context: context,
        icon: icon,
        title: title ?? 'Успешно',
        message: message,
      );

  static void showInfo(
    BuildContext context, {
    IconData icon = Icons.info_rounded,
    String? title,
    String? message,
  }) =>
      _show(
        context: context,
        icon: icon,
        title: title ?? 'Информация',
        message: message,
      );

  static void _show({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required String title,
    String? message,
  }) {
    late OverlayEntry entry;
    Overlay.of(context).insert(
      entry = OverlayEntry(
        builder: (context) {
          final bottomInset = MediaQuery.of(context).viewInsets.bottom;
          return Positioned(
            bottom: bottomInset + 16,
            right: 16,
            left: 16,
            child: Material(
              color: Colors.transparent,
              child: _CustomSnackBarWidget(
                icon: icon,
                iconColor: iconColor,
                title: title,
                message: message,
                removeOverlayEntry: () => entry.remove(),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// {@template toast_notification}
/// CustomSnackBar widget.
/// {@endtemplate}
class _CustomSnackBarWidget extends StatefulWidget {
  /// {@macro toast_notification}
  const _CustomSnackBarWidget({
    required this.icon,
    this.iconColor,
    required this.title,
    this.message,
    required this.removeOverlayEntry,
  });

  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? message;
  final VoidCallback removeOverlayEntry;

  @override
  State<_CustomSnackBarWidget> createState() => __CustomSnackBarWidgetState();
}

class __CustomSnackBarWidgetState extends State<_CustomSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    );

    _controller.addStatusListener(_statusListener);
    super.initState();
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.removeOverlayEntry();
    } else if (status == AnimationStatus.completed) {
      Future.delayed(
        const Duration(seconds: 3),
        () => _controller.reverse(),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _animation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surface,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                widget.icon,
                size: 32,
                color: widget.iconColor,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                    ),
                    if (widget.message != null)
                      Text(
                        widget.message!,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.close),
                onPressed: () async {
                  await _controller.reverse();
                  widget.removeOverlayEntry();
                },
              ),
            ],
          ),
        ),
      );
}
