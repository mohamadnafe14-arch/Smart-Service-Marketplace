import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_update.dart';
import 'package:smart_service_marketplace/features/profile/data/repo/profile_repo.dart';
import 'package:http/http.dart' as http;

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<Failure, UserInformation>> getUserInformation({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${kBaseUrl}api/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final userInformation = UserInformation.fromJson(map['data']["user"]);
        return Right(userInformation);
      } else {
        return Left(Failure(map['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserInformation>> updateUserInformation({
    required UserUpdate userUpdate,
    required String token,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${kBaseUrl}api/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userUpdate.toJson()),
      );
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final userInformation = UserInformation.fromJson(
          map['data']["profile"],
        );
        return Right(userInformation);
      } else {
        return Left(Failure(map['message'] ?? 'Unknown error'));
      }
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
