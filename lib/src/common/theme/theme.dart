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
  brightness: Brightness.dark,
  seedColor: const Color(0xFF000000),
  primary: const Color(0xFFECD8BD),
  secondary: const Color(0xFFFFFFFF),
  secondaryContainer: const Color(0xFFD9D9D9),
  background: const Color(0xFF101010),
  onBackground: const Color(0xFF191919),
);
