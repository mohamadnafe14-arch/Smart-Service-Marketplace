import 'package:fpdart/fpdart.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_response_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, OrderResponseModel>> getOrders({
    required String token,
    required int page,
  });
  Future<Either<Failure, String>> updateOrder({
    required String token,
    required String status,
    required String orderId,
  });
}
