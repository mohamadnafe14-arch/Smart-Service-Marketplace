import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/errors/server_failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_update.dart';
import 'package:smart_service_market_place/features/profile/model/repos/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final DioService _dioService;
  ProfileRepoImpl(this._dioService);

  @override
  Future<Either<Failure, UserInformation>> getUserInformation({
    required String token,
  }) async {
    try {
      final response = await _dioService.get(
        path: 'api/profile',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final userInformation = UserInformation.fromMap(
          response.data['data']["user"] as Map<String, dynamic>,
        );
        return Right(userInformation);
      } else {
        return Left(
          Failure(message: response.data['message'] ?? 'Unknown error'),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserInformation>> updateUserInformation({
    required UserUpdate userUpdate,
    required String token,
  }) async {
    try {
      final response = await _dioService.put(
        path: 'api/profile',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: userUpdate.toMap(),
      );
      if (response.statusCode == 200) {
        final userInformation = UserInformation.fromMap(
          response.data['data']["profile"] as Map<String, dynamic>,
        );
        return Right(userInformation);
      } else {
        return Left(
          Failure(message: response.data['message'] ?? 'Unknown error'),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}