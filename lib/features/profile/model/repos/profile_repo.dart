import 'package:fpdart/fpdart.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_update.dart';
abstract class ProfileRepo {
  Future<Either<Failure, UserInformation>> getUserInformation({
    required String token,
  });
  Future<Either<Failure, UserInformation>> updateUserInformation({
    required UserUpdate userUpdate,
    required String token,
  });
}
