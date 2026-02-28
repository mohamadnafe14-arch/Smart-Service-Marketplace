import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:http/http.dart' as http;

class AuthRepoImpl implements AuthRepo {
  final FlutterSecureStorage storage;

  AuthRepoImpl({required this.storage});
  @override
  Future<Either<Failure, User>> authWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            "791573636194-uho4cm652s7nff35rsillt5tg32pfbld.apps.googleusercontent.com",
      );
      final account = await googleSignIn.authenticate();
      final role = await storage.read(key: "role");
      final request = await http.post(
        Uri.parse("${kBaseUrl}api/google"),
        body: jsonEncode({
          "id_token": account.authentication.idToken!,
          "role": role,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      final map = jsonDecode(request.body);
      if (request.statusCode == 200) {
        final data = map['data'];
        final user = User.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        storage.write(key: "token", value: data['access_token']);
        return Right(user);
      }
      return Left(Failure(map['message'] ?? "حدث خطأ غير متوقع"));
    } on Exception catch (e) {
      return Left(Failure("Server Error: ${e.toString()}"));
    }
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
        final data = map['data'];
        final user = User.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        storage.write(key: "token", value: data['access_token']);
        return Right(user);
      } else {
        return Left(Failure(map['message'] ?? "حدث خطأ غير متوقع"));
      }
    } catch (e) {
      return Left(Failure("Server Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final token = await storage.read(key: "token");
    final request = await http.delete(
      Uri.parse("${kBaseUrl}api/logout"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
    final map = jsonDecode(request.body);
    if (request.statusCode == 200) {
      await storage.delete(key: "token");
      return const Right(null);
    } else {
      return Left(Failure(map['message'] ?? "حدث خطأ غير متوقع"));
    }
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
        final data = map['data'];
        final user = User.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        storage.write(key: "token", value: data['access_token']);
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
    final token = await storage.read(key: "token");
    if (token != null) {
      final result = await http.get(
        Uri.parse("${kBaseUrl}api/getUser"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      final map = jsonDecode(result.body);
      if (result.statusCode == 200) {
        final data = map['data'];
        final user = User.fromJson(
          data["user"],
        ).copyWith(token: data['access_token']);
        storage.write(key: "token", value: data['access_token']);
        return Right(user);
      } else {
        return Left(Failure(map['message'] ?? "حدث خطأ غير متوقع"));
      }
    } else {
      return Left(Failure("User Not Found"));
    }
  }

  @override
  Future<void> setRole(String role) async {
    await storage.write(key: "role", value: role);
  }
}
