import 'package:smart_service_market_place/features/profile/model/models/user_update.dart';
import 'package:test/test.dart';

void main() {
  group('UserUpdate', () {
    final fullUser = UserUpdate(
      name: 'John Doe',
      phone: '01012345678',
      city: 'Cairo',
      street: 'Tahrir St',
      addressInDetails: 'Near the square',
      category: 'Plumber',
      experience: '5 years',
    );

    test('constructor assigns all fields correctly', () {
      expect(fullUser.name, 'John Doe');
      expect(fullUser.phone, '01012345678');
      expect(fullUser.city, 'Cairo');
      expect(fullUser.street, 'Tahrir St');
      expect(fullUser.addressInDetails, 'Near the square');
      expect(fullUser.category, 'Plumber');
      expect(fullUser.experience, '5 years');
    });

    test('constructor allows all-null fields', () {
      final user = UserUpdate();
      expect(user.name, isNull);
      expect(user.phone, isNull);
      expect(user.city, isNull);
      expect(user.street, isNull);
      expect(user.addressInDetails, isNull);
      expect(user.category, isNull);
      expect(user.experience, isNull);
    });

    group('copyWith', () {
      test('returns identical values when no args passed', () {
        final copy = fullUser.copyWith();
        expect(copy, equals(fullUser));
      });

      test('overrides only the specified field', () {
        final copy = fullUser.copyWith(name: 'Jane Doe');
        expect(copy.name, 'Jane Doe');
        expect(copy.phone, fullUser.phone);
        expect(copy.city, fullUser.city);
      });

      test('overrides multiple fields', () {
        final copy = fullUser.copyWith(
          city: 'Alexandria',
          experience: '10 years',
        );
        expect(copy.city, 'Alexandria');
        expect(copy.experience, '10 years');
        expect(copy.name, fullUser.name);
      });

      test('cannot set a field back to null via copyWith', () {
        // Known limitation of the `?? this.field` pattern:
        // passing null is indistinguishable from not passing anything.
        final copy = fullUser.copyWith(name: null);
        expect(copy.name, fullUser.name);
      });
    });

    group('toMap / fromMap', () {
      test('toMap includes only non-null fields', () {
        final partial = UserUpdate(name: 'John', city: 'Cairo');
        final map = partial.toMap();

        expect(map, {'name': 'John', 'city': 'Cairo'});
        expect(map.containsKey('phone'), isFalse);
        expect(map.containsKey('street'), isFalse);
      });

      test('toMap on all-null instance returns empty map', () {
        final user = UserUpdate();
        expect(user.toMap(), isEmpty);
      });

      test('toMap includes all fields when fully populated', () {
        final map = fullUser.toMap();
        expect(map, {
          'name': 'John Doe',
          'phone': '01012345678',
          'city': 'Cairo',
          'street': 'Tahrir St',
          'addressInDetails': 'Near the square',
          'category': 'Plumber',
          'experience': '5 years',
        });
      });

      test('fromMap reconstructs an equivalent object', () {
        final map = fullUser.toMap();
        final rebuilt = UserUpdate.fromMap(map);
        expect(rebuilt, equals(fullUser));
      });

      test('fromMap handles missing keys as null', () {
        final rebuilt = UserUpdate.fromMap({'name': 'Solo'});
        expect(rebuilt.name, 'Solo');
        expect(rebuilt.phone, isNull);
        expect(rebuilt.city, isNull);
      });

      test('fromMap handles explicit null values as null', () {
        final rebuilt = UserUpdate.fromMap({'name': 'Solo', 'phone': null});
        expect(rebuilt.name, 'Solo');
        expect(rebuilt.phone, isNull);
      });

      test('fromMap on empty map returns all-null instance', () {
        final rebuilt = UserUpdate.fromMap({});
        expect(rebuilt, equals(UserUpdate()));
      });
    });

    group('toJson / fromJson', () {
      test('round-trips correctly for a fully populated object', () {
        final json = fullUser.toJson();
        final rebuilt = UserUpdate.fromJson(json);
        expect(rebuilt, equals(fullUser));
      });

      test('round-trips correctly for a partially populated object', () {
        final partial = UserUpdate(phone: '0100000000');
        final json = partial.toJson();
        final rebuilt = UserUpdate.fromJson(json);
        expect(rebuilt, equals(partial));
      });

      test('toJson omits null fields', () {
        final partial = UserUpdate(name: 'Ali');
        expect(partial.toJson(), '{"name":"Ali"}');
      });

      test('fromJson parses an empty object', () {
        final rebuilt = UserUpdate.fromJson('{}');
        expect(rebuilt, equals(UserUpdate()));
      });
    });

    group('toString', () {
      test('includes all field values', () {
        final str = fullUser.toString();
        expect(str, contains('name: John Doe'));
        expect(str, contains('phone: 01012345678'));
        expect(str, contains('city: Cairo'));
        expect(str, contains('street: Tahrir St'));
        expect(str, contains('addressInDetails: Near the square'));
        expect(str, contains('category: Plumber'));
        expect(str, contains('experience: 5 years'));
      });

      test('shows null for unset fields', () {
        final user = UserUpdate(name: 'Solo');
        expect(user.toString(), contains('phone: null'));
      });
    });

    group('equality & hashCode', () {
      test('two instances with same values are equal', () {
        final a = UserUpdate(name: 'A', phone: '111');
        final b = UserUpdate(name: 'A', phone: '111');
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('instances with different values are not equal', () {
        final a = UserUpdate(name: 'A');
        final b = UserUpdate(name: 'B');
        expect(a, isNot(equals(b)));
      });

      test('identical() short-circuit returns true for same instance', () {
        final a = UserUpdate(name: 'A');
        expect(a == a, isTrue);
      });

      test('all-null instances are equal to each other', () {
        expect(UserUpdate(), equals(UserUpdate()));
      });

      test('differs when only one nullable field differs', () {
        final a = fullUser.copyWith();
        final b = fullUser.copyWith(experience: 'Other');
        expect(a, isNot(equals(b)));
      });
    });
  });
}
