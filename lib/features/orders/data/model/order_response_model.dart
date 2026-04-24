import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_model.dart';

class ProvidersResponseModel {
  final List<OrderModel> providers;
  final List<PaginationLink> pagination;
  ProvidersResponseModel({required this.providers, required this.pagination});

  factory ProvidersResponseModel.fromJson(Map<String, dynamic> json) {
    return ProvidersResponseModel(
      providers: (json['data']['providers'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      pagination: (json['pagination'] as List)
          .map((e) => PaginationLink.fromJson(e))
          .toList(),
    );
  }
}
