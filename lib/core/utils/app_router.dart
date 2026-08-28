import 'package:go_router/go_router.dart';
import 'package:smart_service_market_place/features/auth/view/auth_view.dart';
import 'package:smart_service_market_place/features/auth/view/choose_role_view.dart';
import 'package:smart_service_market_place/features/auth/view/splash_view.dart';
import 'package:smart_service_market_place/features/home/provider_home_view.dart';
import 'package:smart_service_market_place/features/home/user_home_view.dart';

class AppRouter {
  static const intialRoute = '/';
  static const chooseRoleRoute = '/choose-role';
  static const authRoute = '/auth';
  static const providerHomeRoute = '/provider-home';
  static const userHomeRoute = '/user-home';
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
      GoRoute(
        path: '/provider-home',
        builder: (context, state) => const ProviderHomeView(),
      ),
      GoRoute(
        path: '/user-home',
        builder: (context, state) => const UserHomeView(),
      ),
    ],
  );
}
