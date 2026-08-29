import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
void main() {
  group('Address', () {
    test('constructor assigns fields correctly', () {
      final address = Address(
        city: 'Cairo',
        street: 'Tahrir St',
        addressInDetails: 'Near the square',
      );
      expect(address.city, 'Cairo');
      expect(address.street, 'Tahrir St');
      expect(address.addressInDetails, 'Near the square');
    });
    test('constructor allows null fields', () {
      final address = Address();
      expect(address.city, isNull);
      expect(address.street, isNull);
      expect(address.addressInDetails, isNull);
    });
    group('copyWith', () {
      test('returns a new instance with updated fields', () {
        final original = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        final updated = original.copyWith(city: 'Giza');
        expect(updated.city, 'Giza');
        expect(updated.street, 'Tahrir St');
        expect(updated.addressInDetails, 'Near the square');
      });
      test('returns identical values when called with no arguments', () {
        final original = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        final copy = original.copyWith();
        expect(copy, original);
        expect(identical(copy, original), isFalse);
      });
      test('does not overwrite fields with null when not provided', () {
        final original = Address(city: 'Cairo');
        final copy = original.copyWith(street: 'New St');
        expect(copy.city, 'Cairo');
        expect(copy.street, 'New St');
      });
    });
    group('toMap / fromMap', () {
      test('toMap returns correct map representation', () {
        final address = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        final map = address.toMap();
        expect(map, {
          'city': 'Cairo',
          'street': 'Tahrir St',
          'addressInDetails': 'Near the square',
        });
      });
      test('toMap handles null fields', () {
        final address = Address();
        final map = address.toMap();
        expect(map, {
          'city': null,
          'street': null,
          'addressInDetails': null,
        });
      });
      test('fromMap creates correct instance', () {
        final map = {
          'city': 'Cairo',
          'street': 'Tahrir St',
          'addressInDetails': 'Near the square',
        };
        final address = Address.fromMap(map);
        expect(address.city, 'Cairo');
        expect(address.street, 'Tahrir St');
        expect(address.addressInDetails, 'Near the square');
      });
      test('fromMap handles missing/null keys', () {
        final map = <String, dynamic>{
          'city': null,
          'street': null,
          'addressInDetails': null,
        };
        final address = Address.fromMap(map);
        expect(address.city, isNull);
        expect(address.street, isNull);
        expect(address.addressInDetails, isNull);
      });
      test('round trip toMap -> fromMap preserves equality', () {
        final original = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        final result = Address.fromMap(original.toMap());
        expect(result, original);
      });
    });

    group('toJson / fromJson', () {
      test('toJson returns valid JSON string', () {
        final address = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        final jsonStr = address.toJson();
        expect(jsonStr, isA<String>());
        expect(jsonStr, contains('Cairo'));
        expect(jsonStr, contains('Tahrir St'));
      });
      test('fromJson creates correct instance', () {
        const jsonStr =
            '{"city":"Cairo","street":"Tahrir St","addressInDetails":"Near the square"}';
        final address = Address.fromJson(jsonStr);
        expect(address.city, 'Cairo');
        expect(address.street, 'Tahrir St');
        expect(address.addressInDetails, 'Near the square');
      });
      test('round trip toJson -> fromJson preserves equality', () {
        final original = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        final result = Address.fromJson(original.toJson());
        expect(result, original);
      });
    });
    group('equality & hashCode', () {
      test('two instances with same values are equal', () {
        final a = Address(city: 'Cairo', street: 'Tahrir St');
        final b = Address(city: 'Cairo', street: 'Tahrir St');
        expect(a, b);
        expect(a.hashCode, b.hashCode);
      });
      test('instances with different values are not equal', () {
        final a = Address(city: 'Cairo');
        final b = Address(city: 'Giza');
        expect(a == b, isFalse);
      });
      test('identical instance is equal to itself', () {
        final a = Address(city: 'Cairo');
        expect(a == a, isTrue);
      });
      test('null field differences affect equality', () {
        final a = Address(city: 'Cairo', street: null);
        final b = Address(city: 'Cairo', street: 'Tahrir St');
        expect(a == b, isFalse);
      });
    });
    group('toString', () {
      test('returns expected formatted string', () {
        final address = Address(
          city: 'Cairo',
          street: 'Tahrir St',
          addressInDetails: 'Near the square',
        );
        expect(
          address.toString(),
          'Address(city: Cairo, street: Tahrir St, addressInDetails: Near the square)',
        );
      });
      test('handles null fields in toString', () {
        final address = Address();
        expect(
          address.toString(),
          'Address(city: null, street: null, addressInDetails: null)',
        );
      });
    });
  });
}