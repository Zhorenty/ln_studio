import 'package:flutter/material.dart';

/// Light theme of this application.
final $lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  useMaterial3: true,
);

/// Dark theme of this application.
final $darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  brightness: Brightness.dark,
  useMaterial3: true,
);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFFFFFF),
  primary: const Color(0xFFFFFFFF),
  secondary: const Color(0xFFD9D9D9),
  onBackground: const Color(0xFF000000),
);

final darkColorScheme = ColorScheme.fromSeed(
  /// TODO(zhorenty): Implement dark theme
  seedColor: Colors.black,
  brightness: Brightness.dark,
);
