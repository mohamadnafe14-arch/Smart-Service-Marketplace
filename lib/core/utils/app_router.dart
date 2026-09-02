import 'package:go_router/go_router.dart';
import 'package:smart_service_market_place/features/auth/view/auth_view.dart';
import 'package:smart_service_market_place/features/auth/view/choose_role_view.dart';
import 'package:smart_service_market_place/features/auth/view/splash_view.dart';
import 'package:smart_service_market_place/features/home/views/provider_home_view.dart';
import 'package:smart_service_market_place/features/home/views/user_home_view.dart';
import 'package:smart_service_market_place/features/profile/view/edit_provider_profile_view.dart';
import 'package:smart_service_market_place/features/profile/view/edit_user_profile_view.dart';

class AppRouter {
  static const intialRoute = '/';
  static const chooseRoleRoute = '/choose-role';
  static const authRoute = '/auth';
  static const providerHomeRoute = '/provider-home';
  static const userHomeRoute = '/user-home';
  static const editUserProfileViewRoute = '/edit-user-profile';
  static const editProviderProfileViewRoute = '/edit-provider-profile';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/choose-role',
        builder: (context, state) => const ChooseRoleView(),
      ),
      GoRoute(path: '/auth', builder: (context, state) => const AuthView()),
      GoRoute(
        path: '/provider-home',
        builder: (context, state) => const ProviderHomeView(),
      ),
      GoRoute(
        path: '/user-home',
        builder: (context, state) => const UserHomeView(),
      ),
      GoRoute(
        path: '/edit-user-profile',
        builder: (context, state) {
          final token = state.extra as String;
          return EditUserProfileView(token: token);
        },
      ),
      GoRoute(
        path: '/edit-provider-profile',
        builder: (context, state) {
          final token = state.extra as String;
          return EditProviderProfileView(token: token);
        },
      ),
    ],
  );
}
