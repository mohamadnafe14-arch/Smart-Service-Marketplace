import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';

abstract class ServicesRepo {
  Future<Either<Failure, List<GetProvider>>> getAllServiceProviders({
    required String token,
    required int page,
  });
  Future<Either<Failure, List<GetProvider>>> getProvidersByCategory({
    required String category,
    required String token,
    required int page,
  });
  Future<Either<Failure, UserInformation>> getProviderById({
    required String token,
    required String id,
  });
}
