import 'package:go_router/go_router.dart';

import '/src/feature/wardrobe/widget/wardrobe_screen.dart';

/// Router of this application.
class AppRouter {
  final router = GoRouter(
    initialLocation: '/wardrobe',
    routes: [
      GoRoute(
        path: '/wardrobe',
        builder: (context, _) => const WardrobeScreen(),
      ),
    ],
  );
}
