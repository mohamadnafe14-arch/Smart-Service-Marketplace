import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/orders/model/order_model.dart';

void main() {
  group('OrderModel', () {
    final tOrderModel = OrderModel(
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

    // Map matching what toMap() ACTUALLY produces (its own key format).
    final tMapFromToMap = <String, dynamic>{
      'status': 'pending',
      'phoneUser': '01000000000',
      'providerName': 'Ahmed Provider',
      'description': 'Fix the sink',
      'userName': 'John Doe',
      'updatedAt': '2024-01-01T12:00:00Z',
      'rating': 4.5,
      'userId': 1,
      'providerId': 2,
      'id': 10,
    };

    // Map matching what fromMap() ACTUALLY expects (snake_case keys).
    final tMapForFromMap = <String, dynamic>{
      'status': 'pending',
      'phone_user': '01000000000',
      'provider_name': 'Ahmed Provider',
      'description': 'Fix the sink',
      'user_name': 'John Doe',
      'updated_at': '2024-01-01T12:00:00Z',
      'rating': 4.5,
      'user_id': 1,
      'provider_id': 2,
      'id': 10,
    };

    test('constructor assigns fields correctly', () {
      expect(tOrderModel.status, 'pending');
      expect(tOrderModel.phoneUser, '01000000000');
      expect(tOrderModel.providerName, 'Ahmed Provider');
      expect(tOrderModel.description, 'Fix the sink');
      expect(tOrderModel.userName, 'John Doe');
      expect(tOrderModel.updatedAt, '2024-01-01T12:00:00Z');
      expect(tOrderModel.rating, 4.5);
      expect(tOrderModel.userId, 1);
      expect(tOrderModel.providerId, 2);
      expect(tOrderModel.id, 10);
    });

    group('copyWith', () {
      test('returns same values when no arguments passed', () {
        final result = tOrderModel.copyWith();
        expect(result, tOrderModel);
      });

      test('overrides only provided fields', () {
        final result = tOrderModel.copyWith(status: 'completed', rating: 5.0);

        expect(result.status, 'completed');
        expect(result.rating, 5.0);
        expect(result.phoneUser, tOrderModel.phoneUser);
        expect(result.providerName, tOrderModel.providerName);
        expect(result.description, tOrderModel.description);
        expect(result.userName, tOrderModel.userName);
        expect(result.updatedAt, tOrderModel.updatedAt);
        expect(result.userId, tOrderModel.userId);
        expect(result.providerId, tOrderModel.providerId);
        expect(result.id, tOrderModel.id);
      });

      test('overrides all fields when all arguments passed', () {
        final result = tOrderModel.copyWith(
          status: 'cancelled',
          phoneUser: '01111111111',
          providerName: 'New Provider',
          description: 'New description',
          userName: 'Jane Doe',
          updatedAt: '2024-02-01T12:00:00Z',
          rating: 3.2,
          userId: 99,
          providerId: 88,
          id: 77,
        );

        expect(result.status, 'cancelled');
        expect(result.phoneUser, '01111111111');
        expect(result.providerName, 'New Provider');
        expect(result.description, 'New description');
        expect(result.userName, 'Jane Doe');
        expect(result.updatedAt, '2024-02-01T12:00:00Z');
        expect(result.rating, 3.2);
        expect(result.userId, 99);
        expect(result.providerId, 88);
        expect(result.id, 77);
      });
    });

    group('toMap', () {
      test('returns a map using camelCase-style keys', () {
        final result = tOrderModel.toMap();
        expect(result, tMapFromToMap);
      });
    });

    group('fromMap', () {
      test('returns a valid model when given snake_case keys', () {
        final result = OrderModel.fromMap(tMapForFromMap);
        expect(result, tOrderModel);
      });

      test('parses int rating correctly by converting to double', () {
        final map = Map<String, dynamic>.from(tMapForFromMap)..['rating'] = 4;
        final result = OrderModel.fromMap(map);
        expect(result.rating, 4.0);
        expect(result.rating, isA<double>());
      });

      test('defaults rating to 0.0 when rating is null', () {
        final map = Map<String, dynamic>.from(tMapForFromMap)..['rating'] = null;
        final result = OrderModel.fromMap(map);
        expect(result.rating, 0.0);
      });
    });

    group('toMap <-> fromMap key mismatch (KNOWN ISSUE)', () {
      test(
        'toMap() output is NOT directly usable with fromMap() '
        'because key casing differs (camelCase vs snake_case)',
        () {
          final mapFromToMap = tOrderModel.toMap();

          // fromMap looks for snake_case keys like 'phone_user', 'user_id', etc.
          // Since toMap() produced camelCase keys instead, those lookups
          // resolve to null, causing either a TypeError (non-nullable String/int
          // fields) or silently wrong data.
          expect(
            () => OrderModel.fromMap(mapFromToMap),
            throwsA(isA<TypeError>()),
            reason:
                'fromMap() expects snake_case keys (phone_user, user_id, '
                'provider_id, provider_name, user_name, updated_at) but '
                'toMap() emits camelCase keys, so required fields resolve '
                'to null and the non-nullable String/int assignment throws.',
          );
        },
      );

      test(
        'fromMap() only works correctly with snake_case keys, '
        'not the keys produced by toMap()',
        () {
          final result = OrderModel.fromMap(tMapForFromMap);
          expect(result, tOrderModel);

          // Confirm the two maps are genuinely different in shape.
          expect(tMapFromToMap.keys.toSet(), isNot(tMapForFromMap.keys.toSet()));
        },
      );
    });

    group('toJson / fromJson', () {
      // NOTE: toJson() internally calls toMap(), so the encoded JSON uses
      // camelCase keys. fromJson() internally calls fromMap(), which expects
      // snake_case keys. So toJson() -> fromJson() round trip is ALSO broken,
      // for the same reason as toMap()/fromMap() above.

      test('toJson returns a JSON string using camelCase keys (from toMap)', () {
        final jsonStr = tOrderModel.toJson();
        final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
        expect(decoded, tMapFromToMap);
      });

      test('fromJson works only when the JSON uses snake_case keys', () {
        final jsonStr = jsonEncode(tMapForFromMap);
        final result = OrderModel.fromJson(jsonStr);
        expect(result, tOrderModel);
      });

      test(
        'toJson() -> fromJson() round trip is BROKEN due to key mismatch',
        () {
          final jsonStr = tOrderModel.toJson(); // camelCase keys
          expect(
            () => OrderModel.fromJson(jsonStr), // expects snake_case keys
            throwsA(isA<TypeError>()),
            reason:
                'Same root cause as toMap/fromMap: toJson() encodes camelCase '
                'keys but fromJson() decodes assuming snake_case keys.',
          );
        },
      );
    });

    group('equality & hashCode', () {
      test('two instances with same values are equal', () {
        final other = OrderModel(
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

        expect(tOrderModel == other, true);
        expect(tOrderModel.hashCode, other.hashCode);
      });

      test('instances with different values are not equal', () {
        final other = tOrderModel.copyWith(status: 'completed');
        expect(tOrderModel == other, false);
      });

      test('identical instance is equal to itself', () {
        expect(tOrderModel == tOrderModel, true);
      });
    });

    group('toString', () {
      test('contains all field values', () {
        final str = tOrderModel.toString();
        expect(str, contains('pending'));
        expect(str, contains('01000000000'));
        expect(str, contains('Ahmed Provider'));
        expect(str, contains('Fix the sink'));
        expect(str, contains('John Doe'));
        expect(str, contains('2024-01-01T12:00:00Z'));
        expect(str, contains('4.5'));
        expect(str, contains('10'));
      });
    });
  });
}