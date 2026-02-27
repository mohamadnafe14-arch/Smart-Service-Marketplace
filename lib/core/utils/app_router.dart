import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/auth_view.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/choose_role_view.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/splash_view.dart';
import 'package:smart_service_marketplace/features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static const String authRoute = '/auth';
  static const String homeRoute = '/home';
  static const String chooseRoleRoute = '/choose-role';
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(path: authRoute, builder: (context, state) => const AuthView()),
      GoRoute(path: homeRoute, builder: (context, state) => const HomeView()),
      GoRoute(
        path: chooseRoleRoute,
        builder: (context, state) => const ChooseRoleView(),
      ),
    ],
  );
}
