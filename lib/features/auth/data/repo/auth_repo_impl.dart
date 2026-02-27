import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:http/http.dart' as http;

class AuthRepoImpl implements AuthRepo {
  final FlutterSecureStorage storage;

  AuthRepoImpl({required this.storage});
  @override
  Future<Either<Failure, User>> authWithGoogle() {
    // TODO: implement authWithgithub
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${kBaseUrl}api/login/"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      final map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final user = User.fromJson(map).copyWith(token: map['access_token']);
        storage.write(key: "user", value: jsonEncode(user.toJson()));
        return Right(user);
      } else {
        return Left(Failure(map['message'] ?? "حدث خطأ غير متوقع"));
      }
    } catch (e) {
      return Left(Failure("Server Error: ${e.toString()}"));
    }
  }

  @override
  Future<void> logout()async {
    storage.delete(key: "user");
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final role = await storage.read(key: "role");
      final response = await http.post(
        Uri.parse("${kBaseUrl}api/register/"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "role": role,
        }),
      );
      final map = jsonDecode(response.body);
      if (response.statusCode == 201) {
        final user = User.fromJson(map).copyWith(token: map["access_token"]);
        storage.write(key: "user", value: jsonEncode(user.toJson()));
        return Right(user);
      } else {
        return Left(Failure(map['message'] ?? "حدث خطأ غير متوقع"));
      }
    } catch (e) {
      return Left(Failure("Server Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    final user = await storage.read(key: "user");
    if (user != null) {
      return Right(User.fromJson(jsonDecode(user)));
    } else {
      return Left(Failure("User Not Found"));
    }
  }

  @override
  Future<void> setRole(String role) async {
    await storage.write(key: "role", value: role);
  }
}
