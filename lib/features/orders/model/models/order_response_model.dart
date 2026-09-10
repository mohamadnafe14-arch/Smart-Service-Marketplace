// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_model.dart';

class OrderResponseModel {
  final List<OrderModel> orders;
  final List<PaginationLink> pagination;
  OrderResponseModel({required this.orders, required this.pagination});

  OrderResponseModel copyWith({
    List<OrderModel>? orders,
    List<PaginationLink>? pagination,
  }) {
    return OrderResponseModel(
      orders: orders ?? this.orders,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orders': orders.map((x) => x.toMap()).toList(),
      'pagination': pagination.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderResponseModel.fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
      orders: (map['data']['orders'] as List)
          .map((e) => OrderModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      pagination: (map['pagination'] as List)
          .map((e) => PaginationLink.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromJson(String source) =>
      OrderResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderResponseModel(orders: $orders, pagination: $pagination)';

  @override
  bool operator ==(covariant OrderResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.orders, orders) &&
        listEquals(other.pagination, pagination);
  }

  @override
  int get hashCode => orders.hashCode ^ pagination.hashCode;
}
