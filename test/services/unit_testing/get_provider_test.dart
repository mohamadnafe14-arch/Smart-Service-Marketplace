import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/model/models/get_provider.dart';

void main() {
  group('GetProvider', () {
    final tProvider = GetProvider(
      id: 1,
      name: 'John Doe',
      role: 'plumber',
      phone: '01000000000',
      category: 'maintenance',
      rating: 5,
    );

    final tMap = <String, dynamic>{
      'id': 1,
      'name': 'John Doe',
      'role': 'plumber',
      'phone': '01000000000',
      'category': 'maintenance',
      'rating': 5,
    };

    final tJson =
        '{"id":1,"name":"John Doe","role":"plumber","phone":"01000000000","category":"maintenance","rating":5}';

    test('constructor assigns fields correctly', () {
      expect(tProvider.id, 1);
      expect(tProvider.name, 'John Doe');
      expect(tProvider.role, 'plumber');
      expect(tProvider.phone, '01000000000');
      expect(tProvider.category, 'maintenance');
      expect(tProvider.rating, 5);
    });

    test('constructor allows all-null fields', () {
      final provider = GetProvider();
      expect(provider.id, isNull);
      expect(provider.name, isNull);
      expect(provider.role, isNull);
      expect(provider.phone, isNull);
      expect(provider.category, isNull);
      expect(provider.rating, isNull);
    });

    group('copyWith', () {
      test('returns identical object when no args passed', () {
        final result = tProvider.copyWith();
        expect(result, tProvider);
      });

      test('overrides only provided fields', () {
        final result = tProvider.copyWith(name: 'Jane Doe', rating: 4);
        expect(result.name, 'Jane Doe');
        expect(result.rating, 4);
        // unchanged fields
        expect(result.id, tProvider.id);
        expect(result.role, tProvider.role);
        expect(result.phone, tProvider.phone);
        expect(result.category, tProvider.category);
      });

      test('can override every field', () {
        final result = tProvider.copyWith(
          id: 2,
          name: 'New',
          role: 'electrician',
          phone: '02000000000',
          category: 'electrical',
          rating: 3,
        );
        expect(result.id, 2);
        expect(result.name, 'New');
        expect(result.role, 'electrician');
        expect(result.phone, '02000000000');
        expect(result.category, 'electrical');
        expect(result.rating, 3);
      });
    });

    group('toMap / fromMap', () {
      test('toMap returns correct map', () {
        expect(tProvider.toMap(), tMap);
      });

      test('fromMap returns correct object', () {
        expect(GetProvider.fromMap(tMap), tProvider);
      });

      test('fromMap handles null fields', () {
        final map = <String, dynamic>{
          'id': null,
          'name': null,
          'role': null,
          'phone': null,
          'category': null,
          'rating': null,
        };
        final result = GetProvider.fromMap(map);
        expect(result.id, isNull);
        expect(result.name, isNull);
        expect(result.role, isNull);
        expect(result.phone, isNull);
        expect(result.category, isNull);
        expect(result.rating, isNull);
      });

      test('fromMap handles missing keys', () {
        final result = GetProvider.fromMap(<String, dynamic>{});
        expect(result.id, isNull);
        expect(result.name, isNull);
      });
    });

    group('toJson / fromJson', () {
      test('toJson returns correct json string', () {
        expect(tProvider.toJson(), tJson);
      });

      test('fromJson returns correct object', () {
        expect(GetProvider.fromJson(tJson), tProvider);
      });

      test('toJson -> fromJson round trip preserves data', () {
        final roundTripped = GetProvider.fromJson(tProvider.toJson());
        expect(roundTripped, tProvider);
      });
    });

    test('toString contains all field values', () {
      final str = tProvider.toString();
      expect(str, contains('John Doe'));
      expect(str, contains('plumber'));
      expect(str, contains('01000000000'));
      expect(str, contains('maintenance'));
      expect(str, contains('5'));
    });

    group('equality & hashCode', () {
      test('two objects with same values are equal', () {
        final other = GetProvider(
          id: 1,
          name: 'John Doe',
          role: 'plumber',
          phone: '01000000000',
          category: 'maintenance',
          rating: 5,
        );
        expect(tProvider, other);
        expect(tProvider.hashCode, other.hashCode);
      });

      test('objects with different values are not equal', () {
        final other = tProvider.copyWith(name: 'Different');
        expect(tProvider == other, isFalse);
      });

      test('identical instance is equal to itself', () {
        expect(tProvider == tProvider, isTrue);
      });
    });
  });
}