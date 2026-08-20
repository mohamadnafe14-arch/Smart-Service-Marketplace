import 'package:go_router/go_router.dart';
import 'package:smart_service_market_place/features/auth/view/auth_view.dart';
import 'package:smart_service_market_place/features/auth/view/choose_role_view.dart';
import 'package:smart_service_market_place/features/auth/view/splash_view.dart';

class AppRouter {
  static const intialRoute = '/';
  static const chooseRoleRoute = '/choose-role';
  static const authRoute = '/auth';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/choose-role',
        builder: (context, state) => const ChooseRoleView(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthView(),
      ),
    ],
  );
}
