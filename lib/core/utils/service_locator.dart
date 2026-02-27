import 'package:get_it/get_it.dart';
import 'package:smart_service_marketplace/core/utils/shared_pref.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo_impl.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPref = SharedPref();
  await sharedPref.init();

  getIt.registerSingleton<SharedPref>(sharedPref);

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(sharedPref: getIt<SharedPref>()),
  );


}
