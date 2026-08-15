import 'package:go_router/go_router.dart';
import 'package:smart_service_market_place/features/splash/view/splash_view.dart';

class AppRouter {
  static const intialRoute = '/';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
    ],
  );
}
