import 'package:flutter/material.dart';

import '/src/common/localization/app_localization.dart';
import '/src/common/router/router.dart';
import '/src/common/theme/theme.dart';

/// {@template app_context}
/// Widget which is responsible for providing the app context.
/// {@endtemplate}
class AppContext extends StatefulWidget {
  /// {@macro app_context}
  const AppContext({super.key});

  @override
  State<AppContext> createState() => _AppContextState();
}

class _AppContextState extends State<AppContext> {
  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MaterialApp.router(
      routerConfig: router.router,
      supportedLocales: AppLocalization.supportedLocales,
      localizationsDelegates: AppLocalization.localizationsDelegates,
      themeMode: ThemeMode.dark,
      theme: $lightThemeData,
      darkTheme: $darkThemeData,
      locale: const Locale('ru', 'RU'),
    );
  }
}
