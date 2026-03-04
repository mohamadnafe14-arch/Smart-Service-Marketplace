import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/provider_information.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserInformation>> getUserInformation();
  Future<Either<Failure, UserInformation>> updateUserInformation(
    UserInformation userInformation,
    String userId,
  );
  Future<Either<Failure, ProviderInformation>> getProviderInformation();
  Future<Either<Failure, ProviderInformation>> updateProviderInformation(
    ProviderInformation providerInformation,
    String providerId,
  );
}
