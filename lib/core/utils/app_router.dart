import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/auth_view.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/forgot_password_view.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/otp_code_view.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/splash_view.dart';
import 'package:smart_service_marketplace/features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static const String authRoute = '/auth';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String otpCodeRoute = '/otp-code';
  static const String homeRoute = '/home';
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
      GoRoute(
        path: otpCodeRoute,
        builder: (context, state) => const OtpCodeView(),
      ),
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
