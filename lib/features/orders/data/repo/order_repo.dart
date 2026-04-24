import 'package:fpdart/fpdart.dart';
import 'package:smart_service_marketplace/core/errors/failure.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_response_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, OrderResponseModel>> getOrders({
    required String token,
    required int page,
  });
}
