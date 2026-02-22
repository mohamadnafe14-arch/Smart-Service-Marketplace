import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/view/splash_view.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const SplashView(),
      ),
    ],
  );
}
