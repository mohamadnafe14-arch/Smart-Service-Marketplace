import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';

abstract class ServicesRepo {
  Future<Either<Failure, List<UserInformation>>> getAllServiceProviders();
  Future<Either<Failure, List<UserInformation>>> getProvidersByCategory({
    required String category,
  });
}
