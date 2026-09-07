import 'package:fpdart/fpdart.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/services/model/models/providers_response_model.dart';

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
  Future<Either<Failure, String>> makeOrder({
    required String token,
    required String id,
    required String description,
    required String phone,
  });
}
