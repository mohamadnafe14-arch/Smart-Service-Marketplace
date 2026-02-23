import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/view/auth_view.dart';
import 'package:smart_service_marketplace/features/auth/view/splash_view.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static const String authRoute = '/auth';
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: authRoute,
        builder: (context, state) => const AuthView(),
      ),
    ],
  );
}
