import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/errors/firebase_auth_failure.dart';
import 'package:smart_service_market_place/core/errors/server_failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/core/services/flutter_secure_storage_service.dart';
import 'package:smart_service_market_place/core/services/google_sign_in_service.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final GoogleSignInService _googleSignInService;
  final DioService _dioService;
  final FlutterSecureStorageService _flutterSecureStorageService;
  const AuthRepoImpl({
    required this._googleSignInService,
    required this._dioService,
    required this._flutterSecureStorageService,
  });
  @override
  Future<Either<Failure, UserModel>> authWithGoogle() async {
    try {
      final credentials = await _googleSignInService.signIn();
      final role = await _flutterSecureStorageService.readRole();
      final response = await _dioService.post(
        path: "/api/google",
        body: {
          "token": credentials.token,
          "role": role,
          "email": credentials.email,
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      final map = response.data;
      if (response.statusCode == 200) {
        final data = map['data'];
        final user = UserModel.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        await _flutterSecureStorageService.writeToken(data['access_token']);
        return Right(user);
      }
      return Left(Failure(message: map['message'] ?? "حدث خطاء غير متوقع"));
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthFailure.fromfirebaseauthexception(e));
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final token = await _flutterSecureStorageService.readToken();
      if (token != null) {
        final result = await _dioService.get(
          path: "/api/getUser",
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );
        final map = result.data;
        if (result.statusCode == 200) {
          final data = map['data'];
          final user = UserModel.fromJson(data["user"]).copyWith(token: token);
          return Right(user);
        } else {
          return Left(Failure(message: map['message'] ?? "حدث خطاء غير متوقع"));
        }
      } else {
        return Left(Failure(message: "User Not Found"));
      }
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioService.post(
        path: "/api/login",
        body: {"email": email, "password": password},
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      final map = response.data;
      if (response.statusCode == 200) {
        final data = map['data'];
        final user = UserModel.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        await _flutterSecureStorageService.writeToken(data['access_token']);
        return Right(user);
      }
      return Left(Failure(message: map['message'] ?? "حدث خطاء غير متوقع"));
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final token = await _flutterSecureStorageService.readToken();
      final response = await _dioService.delete(
        path: "/api/logout",
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        await _flutterSecureStorageService.deleteToken();
        return const Right(null);
      } else {
        return Left(
          Failure(message: response.data['message'] ?? "حدث خطاء غير متوقع"),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final role = await _flutterSecureStorageService.readRole();
      final response = await _dioService.post(
        path: "/api/register",
        body: {
          "email": email,
          "password": password,
          "name": name,
          "role": role,
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      final map = response.data;
      if (response.statusCode == 201) {
        final data = map['data'];
        final user = UserModel.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        await _flutterSecureStorageService.writeToken(data['access_token']);
        return Right(user);
      }
      return Left(Failure(message: map['message'] ?? "حدث خطاء غير متوقع"));
    } on DioException catch (e) {
      return Left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<void> setRole(String role) {
    return _flutterSecureStorageService.writeRole(role);
  }
}
