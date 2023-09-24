import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// Star rating based on a rating value.
class StarRating extends StatefulWidget {
  const StarRating({
    super.key,
    required this.initialRating,
    this.size = 25.0,
    this.onRatingChanged,
  });

  /// Initial rating value.
  final int initialRating;

  /// Size of each star icon.
  final double size;

  /// Callback, called when the rating is changed.
  final Function(int)? onRatingChanged;

  @override
  StarRatingState createState() => StarRatingState();
}

class StarRatingState extends State<StarRating> {
  /// Current rating representation.
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  /// Callback, called when rating was updated.
  void _updateRating(int newRating) {
    setState(() => _currentRating = newRating);
    widget.onRatingChanged?.call(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () =>
              widget.onRatingChanged != null ? _updateRating(index + 1) : null,
          child: Icon(
            index < _currentRating
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            size: widget.size,
            color: index < _currentRating
                ? context.colorScheme.primary
                : context.colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}
