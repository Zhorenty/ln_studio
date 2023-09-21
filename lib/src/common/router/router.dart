import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/widget/custom_bottom_navigation_bar.dart';
import 'package:ln_studio/src/feature/home/widget/home_screen.dart';
import 'package:ln_studio/src/feature/settings/widget/settings_screen.dart';

final _parentKey = GlobalKey<NavigatorState>();

/// Router of this application.
final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _parentKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => CustomBottomNavigationBar(
        navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
