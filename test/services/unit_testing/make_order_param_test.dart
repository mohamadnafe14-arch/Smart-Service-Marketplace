import 'package:smart_service_market_place/features/services/model/models/make_order_param.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('MakeOrderParam', () {
    final param = MakeOrderParam(
      providerId: 'p1',
      token: 'tok123',
      phone: '01000000000',
      pop: () {},
    );

    test('constructor assigns fields correctly', () {
      expect(param.providerId, 'p1');
      expect(param.token, 'tok123');
      expect(param.phone, '01000000000');
    });

    group('copyWith', () {
      test('returns a new instance with updated fields', () {
        final updated = param.copyWith(providerId: 'p2');

        expect(updated.providerId, 'p2');
        expect(updated.token, param.token);
        expect(updated.phone, param.phone);
      });

      test('returns identical values when no arguments passed', () {
        final copy = param.copyWith();

        expect(copy, param); // uses == operator
        expect(copy.providerId, param.providerId);
        expect(copy.token, param.token);
        expect(copy.phone, param.phone);
      });

      test('can update all fields at once', () {
        final updated = param.copyWith(
          providerId: 'p3',
          token: 'newtok',
          phone: '01111111111',
        );

        expect(updated.providerId, 'p3');
        expect(updated.token, 'newtok');
        expect(updated.phone, '01111111111');
      });
    });

    group('toMap / fromMap', () {
      test('toMap returns correct map', () {
        final map = param.toMap();

        expect(map, {
          'providerId': 'p1',
          'token': 'tok123',
          'phone': '01000000000',
        });
      });

      test('fromMap reconstructs an equivalent object', () {
        final map = param.toMap();
        final fromMap = MakeOrderParam.fromMap(map);

        expect(fromMap, param);
      });

      test('fromMap throws if a required field has wrong type', () {
        final badMap = {
          'providerId': 123, // should be String
          'token': 'tok123',
          'phone': '01000000000',
        };

        expect(() => MakeOrderParam.fromMap(badMap), throwsA(isA<TypeError>()));
      });
    });

    group('toJson / fromJson', () {
      test('toJson returns valid JSON string', () {
        final jsonStr = param.toJson();
        final decoded = json.decode(jsonStr);

        expect(decoded, {
          'providerId': 'p1',
          'token': 'tok123',
          'phone': '01000000000',
        });
      });

      test('fromJson reconstructs an equivalent object', () {
        final jsonStr = param.toJson();
        final fromJson = MakeOrderParam.fromJson(jsonStr);

        expect(fromJson, param);
      });

      test('round trip toJson -> fromJson preserves equality', () {
        final roundTripped = MakeOrderParam.fromJson(param.toJson());
        expect(roundTripped, param);
      });
    });

    group('toString', () {
      test('returns expected formatted string', () {
        expect(
          param.toString(),
          'MakeOrderParam(providerId: p1, token: tok123, phone: 01000000000)',
        );
      });
    });

    group('equality (==) and hashCode', () {
      test('two instances with same values are equal', () {
        final other = MakeOrderParam(
          providerId: 'p1',
          token: 'tok123',
          phone: '01000000000',
          pop: () {},
        );

        expect(param, other);
        expect(param.hashCode, other.hashCode);
      });

      test('instances with different providerId are not equal', () {
        final other = param.copyWith(providerId: 'different');
        expect(param == other, isFalse);
      });

      test('instances with different token are not equal', () {
        final other = param.copyWith(token: 'different');
        expect(param == other, isFalse);
      });

      test('instances with different phone are not equal', () {
        final other = param.copyWith(phone: 'different');
        expect(param == other, isFalse);
      });

      test('identical instance is equal to itself', () {
        expect(param == param, isTrue);
      });
    });
  });
}