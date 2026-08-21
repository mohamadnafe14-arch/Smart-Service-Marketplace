import 'package:fpdart/fpdart.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/auth/model/models/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> authWithGoogle();
  Future<Either<Failure, User>> getCurrentUser();
  Future<void> setRole(String role);
}
