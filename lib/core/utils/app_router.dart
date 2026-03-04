import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/auth_view.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/choose_role_view.dart';
import 'package:smart_service_marketplace/features/home/presentation/views/provider_home_view.dart';
import 'package:smart_service_marketplace/features/home/presentation/views/user_home_view.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/edit_provider_profile_view.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/edit_user_profile_view.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static const String authRoute = '/auth';
  static const String userHomeRoute = '/user-home';
  static const String chooseRoleRoute = '/choose-role';
  static const String providerHomeRoute = '/provider-home';
  static const String editProviderProfileRoute = '/edit-provider-profile';
  static const String editUserProfileRoute = '/edit-user-profile';
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const UserHomeView(),
      ),
      GoRoute(path: authRoute, builder: (context, state) => const AuthView()),
      GoRoute(
        path: userHomeRoute,
        builder: (context, state) => const UserHomeView(),
      ),
      GoRoute(
        path: chooseRoleRoute,
        builder: (context, state) => const ChooseRoleView(),
      ),
      GoRoute(
        path: providerHomeRoute,
        builder: (context, state) => const ProviderHomeView(),
      ),
      GoRoute(
        path: editProviderProfileRoute,
        builder: (context, state) => const EditProviderProfileView(),
      ),
      GoRoute(
        path: editUserProfileRoute,
        builder: (context, state) => const EditUserProfileView(),
      ),
    ],
  );
}
