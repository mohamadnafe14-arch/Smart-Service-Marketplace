import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/data/models/provider_response_model.dart';
abstract class ServicesRepo {
  Future<Either<Failure, ProvidersResponseModel>> getProvidersByCategory({
    required String category,
    required String token,
    required int page,
  });
  Future<Either<Failure, UserInformation>> getProviderById({
    required String token,
    required String id,
  });
  Future<Either<Failure,String>> makeOrder({
    required String token,
    required String id,
  });
}
