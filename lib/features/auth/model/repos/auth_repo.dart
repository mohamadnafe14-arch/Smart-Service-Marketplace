import 'package:fpdart/fpdart.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserModel>> authWithGoogle();
  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<void> setRole(String role);
}
