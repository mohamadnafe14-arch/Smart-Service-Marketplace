// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_service_market_place/core/services/dio_service.dart'
    as _i693;
import 'package:smart_service_market_place/core/services/flutter_secure_storage_service.dart'
    as _i448;
import 'package:smart_service_market_place/core/services/google_sign_in_service.dart'
    as _i567;
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo_impl.dart'
    as _i862;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i693.DioService>(() => _i693.DioService());
    gh.lazySingleton<_i448.FlutterSecureStorageService>(
      () => _i448.FlutterSecureStorageService(),
    );
    gh.lazySingleton<_i567.GoogleSignInService>(
      () => _i567.GoogleSignInService(),
    );
    gh.lazySingleton<_i862.AuthRepoImpl>(
      () => _i862.AuthRepoImpl(
        googleSignInService: gh<_i567.GoogleSignInService>(),
        dioService: gh<_i693.DioService>(),
        flutterSecureStorageService: gh<_i448.FlutterSecureStorageService>(),
      ),
    );
    return this;
  }
}
