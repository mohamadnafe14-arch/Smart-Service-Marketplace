import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/core/utils/shared_pref.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:http/http.dart' as http;

class AuthRepoImpl implements AuthRepo {
  SharedPref sharedPref;

  AuthRepoImpl({required this.sharedPref});
  @override
  Future<Either<Failure, User>> authWithGoogle() {
    // TODO: implement authWithgithub
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> authWithgithub() {
    // TODO: implement authWithgithub
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final request = await http.post(Uri.parse("$kBaseUrl/api/register"));
    final map = jsonDecode(request.body);
    if (request.statusCode == 200) {
      await sharedPref.setToken(map['token']);
      return Right(User.fromJson(map).copyWith(token: map['token']));
    } else {
      return Left(Failure(map['message']));
    }
  }

  @override
  Future<Either<Failure, User>> verifyCode({required String code}) {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }
}
