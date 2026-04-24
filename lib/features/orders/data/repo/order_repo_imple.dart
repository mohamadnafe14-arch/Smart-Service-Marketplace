import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_response_model.dart';
import 'package:smart_service_marketplace/features/orders/data/repo/order_repo.dart';
import 'package:http/http.dart' as http;
class OrderRepoImple implements OrderRepo {
  @override
  Future<Either<Failure, OrderResponseModel>> getOrders({
    required String token,
    required int page,
  }) async {
    try {
      final uri = Uri.parse('${kBaseUrl}api/orders&page=$page');
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
        return right(OrderResponseModel.fromJson(body));
      } else {
        return left(Failure(body['message']));
      }
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
