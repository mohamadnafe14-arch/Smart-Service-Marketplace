import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/errors/server_failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_response_model.dart';
import 'package:smart_service_market_place/features/orders/model/repos/order_repo.dart';

@LazySingleton(as: OrderRepo)
class OrderRepoImple implements OrderRepo {
  final DioService _dioService;
  OrderRepoImple(this._dioService);

  @override
  Future<Either<Failure, OrderResponseModel>> getOrders({
    required String token,
    required int page,
  }) async {
    try {
      final response = await _dioService.get(
        path: 'orders',
        queryParameters: {'page': page},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return right(OrderResponseModel.fromMap(response.data));
      } else {
        return left(Failure(message: response.data['message']));
      }
    } on DioException catch (e) {
      return left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return left(Failure(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> updateOrder({
    required String token,
    required String status,
    required String orderId,
  }) async {
    try {
      final response = await _dioService.put(
        path: 'order/update-status/$orderId',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: {'status': status},
      );
      if (response.statusCode == 200) {
        return right(response.data['message']);
      } else {
        return left(Failure(message: response.data['message']));
      }
    } on DioException catch (e) {
      return left(ServerFailuer.fromDioError(dioException: e));
    } catch (e) {
      return left(Failure(message: 'An unexpected error occurred'));
    }
  }
}
