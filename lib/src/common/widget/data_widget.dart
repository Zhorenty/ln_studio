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
    required this.error,
    required this.onRefresh,
    this.customSkeleton,
    this.customErrorWidget,
    required this.child,
  });

  final bool hasData;
  final bool isProcessing;
  final String? error;
  final VoidCallback onRefresh;
  final Widget? customSkeleton;
  final Widget? customErrorWidget;
  final Widget child;

  bool get hasError => error != null;

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
      return InformationWidget.error(
        reloadFunc: onRefresh,
      );
    } else if (!hasData) {
      return InformationWidget.empty(
        reloadFunc: onRefresh,
      );
    } else {
      return child;
    }
  }
}
