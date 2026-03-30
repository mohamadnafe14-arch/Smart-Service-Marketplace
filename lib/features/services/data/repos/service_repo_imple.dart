import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/data/models/provider_response_model.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';
import 'package:http/http.dart' as http;

class ServiceRepoImple implements ServicesRepo {
  @override
  Future<Either<Failure, ProvidersResponseModel>> getProvidersByCategory({
    required String category,
    required String token,
    required int page,
  }) async {
    final uri = Uri.parse(
      '${kBaseUrl}api/providers?category=$category&page=$page',
    );
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final providers = body['data'];
      return right(ProvidersResponseModel.fromJson(providers));
    } else {
      return left(Failure(body['message']));
    }
  }

  @override
  Future<Either<Failure, UserInformation>> getProviderById({
    required String token,
    required String id,
  }) async {
    final uri = Uri.parse('${kBaseUrl}api/providers/$id');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return right(UserInformation.fromJson(body['data']['provider']));
    } else {
      return left(Failure(body['message']));
    }
  }
}
