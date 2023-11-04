import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/information_widget.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';

/// {@template data_widget}
/// DataWidget widget.
/// {@endtemplate}
class DataWidget extends StatelessWidget {
  /// {@macro data_widget}
  const DataWidget({
    super.key,
    required this.hasData,
    required this.isProcessing,
    required this.hasError,
    required this.message,
    required this.onRefresh,
    this.customSkeleton,
    this.customErrorWidget,
    required this.child,
  });

  final bool hasData;
  final bool isProcessing;
  final bool hasError;
  final String? message;
  final VoidCallback onRefresh;
  final Widget? customSkeleton;
  final Widget Function(VoidCallback onRefresh)? customErrorWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!hasData && isProcessing) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: customSkeleton ??
            const Shimmer(
              size: Size.infinite,
              cornerRadius: 25,
            ),
      );
    } else if (!hasData && hasError) {
      return customErrorWidget?.call(onRefresh) ??
          InformationWidget.error(
            reloadFunc: onRefresh,
            description: message,
          );
    } else if (!hasData) {
      return customErrorWidget?.call(onRefresh) ??
          InformationWidget.empty(
            reloadFunc: onRefresh,
            description: message,
          );
    } else {
      return child;
    }
  }
}
