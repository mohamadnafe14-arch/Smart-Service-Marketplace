import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/provider_information.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserInformation>> getUserInformation({
    required String token,
  });
  Future<Either<Failure, UserInformation>> updateUserInformation({
    required UserInformation userInformation,
    required String token,
  });
 
}
