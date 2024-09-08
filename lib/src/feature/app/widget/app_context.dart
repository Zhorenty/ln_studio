import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/scope_widgets.dart';
import 'package:ln_studio/src/feature/auth/widget/auth_scope.dart';

import '/src/common/router/app_router_scope.dart';
import '/src/common/localization/app_localization.dart';
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
  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final router = AppRouterScope.of(context);
    return MaterialApp.router(
      routerConfig: router,
      supportedLocales: Localization.supportedLocales,
      localizationsDelegates: Localization.localizationDelegates,
      themeMode: ThemeMode.dark,
      theme: $lightThemeData,
      darkTheme: $darkThemeData,
      locale: const Locale('ru', 'RU'),
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        key: _globalKey,
        minScaleFactor: 1.0,
        maxScaleFactor: 2.0,
        child: ScopesProvider(
          providers: const [
            ScopeProvider(buildScope: AuthenticationScope.new),
          ],
          child: child!,
        ),
      ),
    );
  }
}
