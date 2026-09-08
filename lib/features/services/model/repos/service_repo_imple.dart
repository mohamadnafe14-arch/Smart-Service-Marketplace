import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/services/model/models/providers_response_model.dart';
import 'package:smart_service_market_place/features/services/model/repos/service_repo.dart';

@LazySingleton(as: ServicesRepo)
class ServiceRepoImple implements ServicesRepo {
  final DioService _dioService;

  ServiceRepoImple({required this._dioService});
  @override
  Future<Either<Failure, ProvidersResponseModel>> getProvidersByCategory({
    required String category,
    required String token,
    required int page,
  }) async {
    try {
      final response = await _dioService.get(
        path: 'providers',
        queryParameters: {'category': category, 'page': page},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      final data = response.data as Map<String, dynamic>;
      if (response.statusCode == 200) {
        log(response.data.toString());
        return right(ProvidersResponseModel.fromMap(data));
      } else {
        return left(Failure(message: data['message']));
      }
    } on Exception catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserInformation>> getProviderById({
    required String token,
    required String id,
  }) async {
    try {
      final response = await _dioService.get(
        path: 'provider/$id',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return right(
          UserInformation.fromMap(response.data['data']['provider']),
        );
      } else {
        return left(Failure(message: response.data['message']));
      }
    } on Exception catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> makeOrder({
    required String token,
    required String id,
    required String description,
    required String phone,
  }) async {
    try {
      final response = await _dioService.post(
        path: 'order/store/$id',
        body: {'description': description, 'phone_user': phone},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return right(response.data['data']['order_id'].toString());
      } else {
        return left(Failure(message: response.data['message']));
      }
    } on Exception catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
