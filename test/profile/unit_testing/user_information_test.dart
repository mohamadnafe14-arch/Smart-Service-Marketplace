import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';

void main() {
  final address = Address(
    city: 'Cairo',
    street: 'Tahrir St',
    addressInDetails: 'Near the square',
  );
  final statistics = Statistics(totalNumberOfOrders: 10, finishedOrders: 5);
  final rating = Rating(rate: 4.5, count: 12);
  final userInfo = UserInformation(
    name: 'Ahmed',
    id: 101,
    email: 'ahmed@example.com',
    phone: '+966500000000',
    createdSince: '2024-01-01',
    address: address,
    statistics: statistics,
    rating: rating,
    category: 'Plumber',
    experiences: '5 years',
  );
  group('UserInformation', () {
    test('constructor assigns fields correctly', () {
      expect(userInfo.name, 'Ahmed');
      expect(userInfo.id, 101);
      expect(userInfo.email, 'ahmed@example.com');
      expect(userInfo.phone, '+966500000000');
      expect(userInfo.createdSince, '2024-01-01');
      expect(userInfo.address, address);
      expect(userInfo.statistics, statistics);
      expect(userInfo.rating, rating);
      expect(userInfo.category, 'Plumber');
      expect(userInfo.experiences, '5 years');
    });
    test('constructor allows optional fields to be null', () {
      final user = UserInformation(
        name: 'Sara',
        id: 202,
        email: 'sara@example.com',
        createdSince: '2024-02-02',
        address: address,
        statistics: statistics,
        rating: rating,
      );
      expect(user.phone, isNull);
      expect(user.category, isNull);
      expect(user.experiences, isNull);
    });

    group('copyWith', () {
      test('returns a new instance with updated values', () {
        final updated = userInfo.copyWith(
          name: 'Ali',
          phone: '+966511111111',
          category: 'Electrician',
        );
        expect(updated.name, 'Ali');
        expect(updated.id, 101);
        expect(updated.email, 'ahmed@example.com');
        expect(updated.phone, '+966511111111');
        expect(updated.createdSince, '2024-01-01');
        expect(updated.address, address);
        expect(updated.statistics, statistics);
        expect(updated.rating, rating);
        expect(updated.category, 'Electrician');
        expect(updated.experiences, '5 years');
      });
      test('returns equal instance when called with no arguments', () {
        final copy = userInfo.copyWith();
        expect(copy, userInfo);
        expect(identical(copy, userInfo), isFalse);
      });
    });
    group('toMap / fromMap', () {
      test('toMap returns correct map representation', () {
        final map = userInfo.toMap();
        expect(map, {
          'name': 'Ahmed',
          'id': 101,
          'email': 'ahmed@example.com',
          'phone': '+966500000000',
          'createdSince': '2024-01-01',
          'address': address.toMap(),
          'statistics': statistics.toMap(),
          'rating': rating.toMap(),
          'category': 'Plumber',
          'experiences': '5 years',
        });
      });
      test('fromMap creates correct instance', () {
        final map = userInfo.toMap();
        final result = UserInformation.fromMap(map);
        expect(result, userInfo);
      });
      test('fromMap handles null optional values', () {
        final map = {
          'name': 'Sara',
          'id': 202,
          'email': 'sara@example.com',
          'phone': null,
          'createdSince': '2024-02-02',
          'address': address.toMap(),
          'statistics': statistics.toMap(),
          'rating': rating.toMap(),
          'category': null,
          'experiences': null,
        };
        final result = UserInformation.fromMap(map);
        expect(result.name, 'Sara');
        expect(result.phone, isNull);
        expect(result.category, isNull);
        expect(result.experiences, isNull);
      });
      test('round trip toMap -> fromMap preserves equality', () {
        final result = UserInformation.fromMap(userInfo.toMap());
        expect(result, userInfo);
      });
    });
    group('toJson / fromJson', () {
      test('toJson returns valid JSON string', () {
        final jsonStr = userInfo.toJson();
        expect(jsonStr, isA<String>());
        expect(jsonStr, contains('Ahmed'));
        expect(jsonStr, contains('ahmed@example.com'));
        expect(jsonStr, contains('Plumber'));
      });
      test('fromJson creates correct instance', () {
        final result = UserInformation.fromJson(userInfo.toJson());
        expect(result, userInfo);
      });
      test('toJson -> fromJson round trip preserves equality', () {
        final result = UserInformation.fromJson(userInfo.toJson());
        expect(result, userInfo);
      });
    });
    group('equality & hashCode', () {
      test('two instances with same values are equal', () {
        final other = UserInformation(
          name: 'Ahmed',
          id: 101,
          email: 'ahmed@example.com',
          phone: '+966500000000',
          createdSince: '2024-01-01',
          address: address,
          statistics: statistics,
          rating: rating,
          category: 'Plumber',
          experiences: '5 years',
        );
        expect(userInfo, other);
        expect(userInfo.hashCode, other.hashCode);
      });
      test('instances with different values are not equal', () {
        final other = UserInformation(
          name: 'Ahmed',
          id: 101,
          email: 'ahmed@example.com',
          phone: '+966500000000',
          createdSince: '2024-01-01',
          address: address,
          statistics: statistics,
          rating: rating,
          category: 'Engineer',
          experiences: '5 years',
        );
        expect(userInfo == other, isFalse);
      });
      test('identical instance is equal to itself', () {
        expect(userInfo == userInfo, isTrue);
      });
    });
    group('toString', () {
      test('returns expected formatted string', () {
        expect(
          userInfo.toString(),
          'UserInformation(name: Ahmed, id: 101, email: ahmed@example.com, phone: +966500000000, createdSince: 2024-01-01, address: $address, statistics: $statistics, rating: $rating, category: Plumber, experiences: 5 years)',
        );
      });
    });
  });
}
