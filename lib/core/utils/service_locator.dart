import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_service_marketplace/firebase_options.dart';
final getIt = GetIt.instance;
Future<void> setupServiceLocator() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(storage: getIt<FlutterSecureStorage>()),
  );
}
