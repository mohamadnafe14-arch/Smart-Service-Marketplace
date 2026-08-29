import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
void main() {
  group('Rating', () {
    test('constructor sets fields correctly', () {
      final rating = Rating(rate: 4.5, count: 10);
      expect(rating.rate, 4.5);
      expect(rating.count, 10);
    });
    group('copyWith', () {
      test('returns a new instance with updated rate', () {
        final rating = Rating(rate: 4.5, count: 10);
        final updated = rating.copyWith(rate: 3.0);
        expect(updated.rate, 3.0);
        expect(updated.count, 10);
      });
      test('returns a new instance with updated count', () {
        final rating = Rating(rate: 4.5, count: 10);
        final updated = rating.copyWith(count: 20);
        expect(updated.rate, 4.5);
        expect(updated.count, 20);
      });
      test('returns an equal instance when called with no args', () {
        final rating = Rating(rate: 4.5, count: 10);
        final updated = rating.copyWith();
        expect(updated, rating);
      });
    });
    group('toMap / fromMap', () {
      test('toMap returns correct map', () {
        final rating = Rating(rate: 4.5, count: 10);
        final map = rating.toMap();
        expect(map, <String, dynamic>{'rate': 4.5, 'count': 10});
      });
      test('fromMap returns correct Rating', () {
        final map = <String, dynamic>{'rate': 4.5, 'count': 10};
        final rating = Rating.fromMap(map);
        expect(rating, Rating(rate: 4.5, count: 10));
      });
      test('fromMap returns default Rating when map is empty', () {
        final rating = Rating.fromMap(<String, dynamic>{});
        expect(rating, Rating(rate: 0.0, count: 0));
      });
      test('fromMap handles missing rate key with default', () {
        final map = <String, dynamic>{'count': 5};
        final rating = Rating.fromMap(map);
        expect(rating.rate, 0.0);
        expect(rating.count, 5);
      });
      test('fromMap handles missing count key with default', () {
        final map = <String, dynamic>{'rate': 3.2};
        final rating = Rating.fromMap(map);
        expect(rating.rate, 3.2);
        expect(rating.count, 0);
      });
      test('toMap -> fromMap roundtrip preserves values', () {
        final original = Rating(rate: 2.7, count: 99);
        final result = Rating.fromMap(original.toMap());
        expect(result, original);
      });
    });
    group('toJson / fromJson', () {
      test('toJson returns valid JSON string', () {
        final rating = Rating(rate: 4.5, count: 10);
        final jsonStr = rating.toJson();
        expect(jsonStr, '{"rate":4.5,"count":10}');
      });
      test('fromJson returns correct Rating', () {
        const jsonStr = '{"rate":4.5,"count":10}';
        final rating = Rating.fromJson(jsonStr);
        expect(rating, Rating(rate: 4.5, count: 10));
      });
      test('toJson -> fromJson roundtrip preserves values', () {
        final original = Rating(rate: 1.1, count: 42);
        final result = Rating.fromJson(original.toJson());
        expect(result, original);
      });
    });
    group('toString', () {
      test('returns correct string representation', () {
        final rating = Rating(rate: 4.5, count: 10);
        expect(rating.toString(), 'Rating(rate: 4.5, count: 10)');
      });
    });
    group('equality and hashCode', () {
      test('two instances with same values are equal', () {
        final r1 = Rating(rate: 4.5, count: 10);
        final r2 = Rating(rate: 4.5, count: 10);
        expect(r1, r2);
        expect(r1.hashCode, r2.hashCode);
      });
      test('instances with different rate are not equal', () {
        final r1 = Rating(rate: 4.5, count: 10);
        final r2 = Rating(rate: 4.0, count: 10);
        expect(r1 == r2, false);
      });
      test('instances with different count are not equal', () {
        final r1 = Rating(rate: 4.5, count: 10);
        final r2 = Rating(rate: 4.5, count: 20);
        expect(r1 == r2, false);
      });
      test('identical instance is equal to itself', () {
        final r1 = Rating(rate: 4.5, count: 10);
        expect(r1 == r1, true);
      });
    });
  });
}