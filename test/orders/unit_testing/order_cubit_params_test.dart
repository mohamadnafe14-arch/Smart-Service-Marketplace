import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_cubit_params.dart';

void main() {
  group('OrderCubitParams', () {
    final params = OrderCubitParams(
      token: 'test-token',
      id: 'provider-1',
      role: 'provider',
    );

    test('constructor assigns all values', () {
      expect(params.token, 'test-token');
      expect(params.id, 'provider-1');
      expect(params.role, 'provider');
    });

    group('copyWith', () {
      test('returns an equivalent copy when no values are provided', () {
        expect(params.copyWith(), params);
      });

      test('replaces only the provided values', () {
        final result = params.copyWith(role: 'user', id: 'user-1');

        expect(result.token, params.token);
        expect(result.id, 'user-1');
        expect(result.role, 'user');
      });
    });

    group('map and JSON serialization', () {
      test('toMap returns all values', () {
        expect(params.toMap(), {
          'token': 'test-token',
          'id': 'provider-1',
          'role': 'provider',
        });
      });

      test('fromMap reconstructs the value object', () {
        expect(OrderCubitParams.fromMap(params.toMap()), params);
      });

      test('toJson returns JSON containing all values', () {
        expect(jsonDecode(params.toJson()), params.toMap());
      });

      test('fromJson reconstructs the value object', () {
        expect(OrderCubitParams.fromJson(params.toJson()), params);
      });
    });

    group('equality', () {
      test('objects with the same values are equal and share a hash code', () {
        final other = OrderCubitParams(
          token: 'test-token',
          id: 'provider-1',
          role: 'provider',
        );

        expect(params, other);
        expect(params.hashCode, other.hashCode);
      });

      test('objects with different values are not equal', () {
        expect(params == params.copyWith(token: 'different-token'), isFalse);
      });

      test('an object is equal to itself', () {
        expect(params == params, isTrue);
      });
    });

    test('toString includes the parameter values', () {
      final value = params.toString();

      expect(value, contains('OrderCubitParams'));
      expect(value, contains('test-token'));
      expect(value, contains('provider-1'));
      expect(value, contains('provider'));
    });
  });
}
