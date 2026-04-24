import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_model.dart';

class OrderResponseModel {
  final List<OrderModel> orders;
  final List<PaginationLink> pagination;
  OrderResponseModel({required this.orders, required this.pagination});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      orders: (json['data']['orders'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      pagination: (json['pagination'] as List)
          .map((e) => PaginationLink.fromJson(e))
          .toList(),
    );
  }
}
