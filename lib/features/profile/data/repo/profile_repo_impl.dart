import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/provider_information.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo{
  @override
  Future<Either<Failure, ProviderInformation>> getProviderInformation({required String token}) {
    // TODO: implement getProviderInformation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserInformation>> getUserInformation({required String token}) {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProviderInformation>> updateProviderInformation({required ProviderInformation providerInformation, required String token}) {
    // TODO: implement updateProviderInformation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserInformation>> updateUserInformation({required UserInformation userInformation, required String token}) {
    // TODO: implement updateUserInformation
    throw UnimplementedError();
  }
}