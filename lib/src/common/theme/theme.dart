import 'package:flutter/material.dart';

/// Light theme of this application.
final $lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  useMaterial3: true,
);

const lightColorScheme = ColorScheme.light(
  primary: Color(0xFFFFFFFF),
  secondary: Color(0xFFD9D9D9),
  onBackground: Color(0xFF000000),
);

/// Dark theme of this application.
final $darkThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  bottomNavigationBarTheme: bottomNavigationBarThemeDataDark,
  splashColor: darkColorScheme.scrim,
  highlightColor: darkColorScheme.scrim,
  textTheme: Typography.whiteHelsinki,
  brightness: Brightness.dark,
  dividerTheme: DividerThemeData(color: darkColorScheme.onBackground),
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.onBackground,
    // surfaceTintColor: const Color(0x1FFFFFFF),
    surfaceTintColor: darkColorScheme.onBackground,
  ),
  iconTheme: IconThemeData(color: darkColorScheme.primary),
  scaffoldBackgroundColor: darkColorScheme.background,
  datePickerTheme: DatePickerThemeData(
    backgroundColor: darkColorScheme.onBackground,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkColorScheme.background,
    modalBackgroundColor: darkColorScheme.background,
  ),
  extensions: [
    AppColors(
      avatarColors: [
        const Color(0xFFD2B334),
        const Color(0xFF2192FF),
        const Color(0xFF9C27B0),
        const Color(0xFFFF9800),
        const Color(0xFF0094A7),
        const Color(0xFF7F81FF),
        const Color(0xFF5D4037),
        const Color(0xFF00695C),
        const Color(0xFFE91E63),
        const Color(0xFFE040FB),
        const Color(0xFF607D8B),
        const Color(0xFF8BC34A),
        const Color(0xFF795548),
        const Color(0xFF009688)
      ],
    ),
  ],
);

const darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: Color(0xFFECD8BD),
  secondary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF9E9E9E),
  secondaryContainer: Color(0xFFD9D9D9),
  background: Color(0xFF101010),
  onBackground: Color(0xFF191919),
  scrim: Color(0x00000000),
);

const bottomNavigationBarThemeDataDark = BottomNavigationBarThemeData(
  backgroundColor: Color(0x1F000000),
);

/// Additional [Color]s used throughout the application.
class AppColors extends ThemeExtension<AppColors> {
  AppColors({required this.avatarColors});

  /// [Color]s associated with the [Employee].
  ///
  /// Used for [AvatarWidget]s.
  final List<Color> avatarColors;

  @override
  ThemeExtension<AppColors> copyWith({List<Color>? avatarColors}) => AppColors(
        avatarColors: avatarColors ?? this.avatarColors,
      );

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      avatarColors: other.avatarColors.isNotEmpty ? other.avatarColors : [],
    );
  }
}

/// Extension adding [AppColors] handy getter from the [ThemeData].
extension ThemeStylesExtension on ThemeData {
  /// Returns the [AppColors] of this [ThemeData].
  AppColors get colors => extension<AppColors>()!;
}
