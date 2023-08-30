import 'package:go_router/go_router.dart';

import '/src/feature/home/widget/home_screen.dart';

/// Router of this application.
class AppRouter {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, _) => const WardrobeScreen(),
      ),
    ],
  );
}
