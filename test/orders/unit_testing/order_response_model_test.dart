import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_model.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_response_model.dart';

void main() {
  group('OrderResponseModel', () {
    final order = OrderModel(
      status: 'pending',
      phoneUser: '01000000000',
      providerName: 'Ahmed Provider',
      description: 'Fix the sink',
      userName: 'John Doe',
      updatedAt: '2024-01-01T12:00:00Z',
      rating: 4.5,
      userId: 1,
      providerId: 2,
      id: 10,
    );

    final paginationLink = PaginationLink(
      url: 'https://example.com/orders?page=2',
      label: '2',
      active: false,
    );

    final response = OrderResponseModel(
      orders: [order],
      pagination: [paginationLink],
    );

    Map<String, dynamic> buildApiPayload() {
      return {
        'data': {
          'orders': [
            jsonEncode({
              'status': order.status,
              'phone_user': order.phoneUser,
              'provider_name': order.providerName,
              'description': order.description,
              'user_name': order.userName,
              'updated_at': order.updatedAt,
              'rating': order.rating,
              'user_id': order.userId,
              'provider_id': order.providerId,
              'id': order.id,
            }),
          ],
        },
        'pagination': [paginationLink.toJson()],
      };
    }

    test('constructor assigns orders and pagination', () {
      expect(response.orders, [order]);
      expect(response.pagination, [paginationLink]);
    });

    group('copyWith', () {
      test('returns an equivalent copy when no values are provided', () {
        expect(response.copyWith(), response);
      });

      test('replaces only the provided fields', () {
        final replacementOrder = order.copyWith(status: 'completed');
        final replacementLink = paginationLink.copyWith(
          label: '1',
          active: true,
        );

        final result = response.copyWith(
          orders: [replacementOrder],
          pagination: [replacementLink],
        );

        expect(result.orders, [replacementOrder]);
        expect(result.pagination, [replacementLink]);
      });
    });

    group('map and JSON serialization', () {
      test('toMap serializes nested models into plain maps', () {
        expect(response.toMap(), {
          'orders': [order.toMap()],
          'pagination': [paginationLink.toMap()],
        });
      });

      test('fromMap reconstructs nested models from the API payload shape', () {
        final result = OrderResponseModel.fromMap(buildApiPayload());
        expect(result, response);
      });

      test('fromJson reconstructs nested models from JSON payload', () {
        final payload = jsonEncode(buildApiPayload());
        final result = OrderResponseModel.fromJson(payload);
        expect(result, response);
      });

      test('toJson returns a JSON string for the model', () {
        final jsonStr = response.toJson();
        final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;

        expect(decoded['orders'], [order.toMap()]);
        expect(decoded['pagination'], [paginationLink.toMap()]);
      });
    });

    test('toString includes both collections', () {
      final value = response.toString();

      expect(value, contains('OrderResponseModel'));
      expect(value, contains(order.toString()));
      expect(value, contains(paginationLink.toString()));
    });

    group('equality', () {
      test('responses with different orders are not equal', () {
        final other = response.copyWith(
          orders: [order.copyWith(status: 'completed')],
        );

        expect(response == other, isFalse);
      });

      test('identical instance is equal to itself', () {
        expect(response == response, isTrue);
      });
    });
  });
}
