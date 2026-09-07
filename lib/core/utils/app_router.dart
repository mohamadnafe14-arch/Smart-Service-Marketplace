import 'package:go_router/go_router.dart';
import 'package:smart_service_market_place/features/auth/view/auth_view.dart';
import 'package:smart_service_market_place/features/auth/view/choose_role_view.dart';
import 'package:smart_service_market_place/features/auth/view/splash_view.dart';
import 'package:smart_service_market_place/features/home/views/provider_home_view.dart';
import 'package:smart_service_market_place/features/home/views/user_home_view.dart';
import 'package:smart_service_market_place/features/profile/view/edit_provider_profile_view.dart';
import 'package:smart_service_market_place/features/profile/view/edit_user_profile_view.dart';
import 'package:smart_service_market_place/features/services/view/provider_details_view.dart';

class AppRouter {
  static const intialRoute = '/';
  static const chooseRoleRoute = '/choose-role';
  static const authRoute = '/auth';
  static const providerHomeRoute = '/provider-home';
  static const userHomeRoute = '/user-home';
  static const editUserProfileViewRoute = '/edit-user-profile';
  static const editProviderProfileViewRoute = '/edit-provider-profile';
  static const providerDetailsViewRoute = '/provider-details';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path:chooseRoleRoute,
        builder: (context, state) => const ChooseRoleView(),
      ),
      GoRoute(path: authRoute, builder: (context, state) => const AuthView()),
      GoRoute(
        path: providerHomeRoute,
        builder: (context, state) => const ProviderHomeView(),
      ),
      GoRoute(
        path: userHomeRoute,
        builder: (context, state) => const UserHomeView(),
      ),
      GoRoute(
        path: editUserProfileViewRoute,
        builder: (context, state) {
          final token = state.extra as String;
          return EditUserProfileView(token: token);
        },
      ),
      GoRoute(
        path: editProviderProfileViewRoute,
        builder: (context, state) {
          final token = state.extra as String;
          return EditProviderProfileView(token: token);
        },
      ),
      GoRoute(
        path: providerDetailsViewRoute,
        builder: (context, state) {
          final id = state.extra as int;
          return ProviderDetailsView(id: id);
        }
      ),
    ],
  );
}
