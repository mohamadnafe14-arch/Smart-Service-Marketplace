import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/view/auth_view.dart';
import 'package:smart_service_marketplace/features/auth/view/forgot_password_view.dart';
import 'package:smart_service_marketplace/features/auth/view/splash_view.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static const String authRoute = '/auth';
  static const String forgotPasswordRoute = '/forgot-password';
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(path: authRoute, builder: (context, state) => const AuthView()),
      GoRoute(
        path: forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordView(),
      ),
    ],
  );
}
