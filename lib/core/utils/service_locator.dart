import 'package:get_it/get_it.dart';
import 'package:smart_service_marketplace/core/utils/shared_pref.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo_impl.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/cubit/auth_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<SharedPref>(SharedPref()..init());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(sharedPref: getIt<SharedPref>()),
  );
  getIt.registerSingleton<AuthCubit>(AuthCubit(authRepo: getIt<AuthRepo>()));
}
