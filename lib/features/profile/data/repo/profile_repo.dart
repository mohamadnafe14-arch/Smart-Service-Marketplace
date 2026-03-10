import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_update.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserInformation>> getUserInformation({
    required String token,
  });
  Future<Either<Failure, UserInformation>> updateUserInformation({
    required UserUpdate userUpdate,
    required String token,
  });
 
}
