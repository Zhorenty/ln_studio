import 'package:flutter/material.dart';

/// {@template booking_screen}
/// BookingScreen widget.
/// {@endtemplate}
class BookingScreen extends StatelessWidget {
  /// {@macro booking_screen}
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Записи'),
        ),
      );
}
