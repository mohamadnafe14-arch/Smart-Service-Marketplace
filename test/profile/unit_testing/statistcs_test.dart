import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
void main() {
  group('Statistics', () {
    final statistics = Statistics(totalNumberOfOrders: 10, finishedOrders: 5);
    test('constructor sets fields correctly', () {
      expect(statistics.totalNumberOfOrders, 10);
      expect(statistics.finishedOrders, 5);
    });
    group('copyWith', () {
      test('returns a new object with updated totalNumberOfOrders', () {
        final result = statistics.copyWith(totalNumberOfOrders: 20);
        expect(result.totalNumberOfOrders, 20);
        expect(result.finishedOrders, 5);
      });
      test('returns a new object with updated finishedOrders', () {
        final result = statistics.copyWith(finishedOrders: 8);
        expect(result.totalNumberOfOrders, 10);
        expect(result.finishedOrders, 8);
      });
      test('returns an identical object when no arguments passed', () {
        final result = statistics.copyWith();
        expect(result, statistics);
      });
      test('returns a new object with all fields updated', () {
        final result = statistics.copyWith(
          totalNumberOfOrders: 100,
          finishedOrders: 50,
        );
        expect(result.totalNumberOfOrders, 100);
        expect(result.finishedOrders, 50);
      });
    });
    group('toMap / fromMap', () {
      test('toMap returns correct map', () {
        final map = statistics.toMap();
        expect(map, <String, dynamic>{
          'totalNumberOfOrders': 10,
          'finishedOrders': 5,
        });
      });
      test('fromMap returns correct object', () {
        final map = <String, dynamic>{
          'totalNumberOfOrders': 10,
          'finishedOrders': 5,
        };
        final result = Statistics.fromMap(map);
        expect(result, statistics);
      });
      test('fromMap defaults missing totalNumberOfOrders to 0', () {
        final map = <String, dynamic>{'finishedOrders': 5};
        final result = Statistics.fromMap(map);
        expect(result.totalNumberOfOrders, 0);
        expect(result.finishedOrders, 5);
      });
      test('fromMap defaults missing finishedOrders to 0', () {
        final map = <String, dynamic>{'totalNumberOfOrders': 10};
        final result = Statistics.fromMap(map);
        expect(result.totalNumberOfOrders, 10);
        expect(result.finishedOrders, 0);
      });
      test('fromMap defaults both fields to 0 when map is empty', () {
        final result = Statistics.fromMap(<String, dynamic>{});
        expect(result.totalNumberOfOrders, 0);
        expect(result.finishedOrders, 0);
      });
      test('toMap -> fromMap round trip preserves equality', () {
        final result = Statistics.fromMap(statistics.toMap());
        expect(result, statistics);
      });
    });
    group('toJson / fromJson', () {
      test('toJson returns correct json string', () {
        final jsonStr = statistics.toJson();
        expect(jsonStr, '{"totalNumberOfOrders":10,"finishedOrders":5}');
      });
      test('fromJson returns correct object', () {
        const jsonStr = '{"totalNumberOfOrders":10,"finishedOrders":5}';
        final result = Statistics.fromJson(jsonStr);
        expect(result, statistics);
      });
      test('toJson -> fromJson round trip preserves equality', () {
        final result = Statistics.fromJson(statistics.toJson());
        expect(result, statistics);
      });
    });
    group('toString', () {
      test('returns correct string representation', () {
        expect(
          statistics.toString(),
          'Statistics(totalNumberOfOrders: 10, finishedOrders: 5)',
        );
      });
    });
    group('equality and hashCode', () {
      test('two objects with same values are equal', () {
        final other = Statistics(totalNumberOfOrders: 10, finishedOrders: 5);
        expect(statistics == other, true);
        expect(statistics.hashCode == other.hashCode, true);
      });
      test('same instance is equal to itself', () {
        expect(statistics == statistics, true);
      });
      test('objects with different totalNumberOfOrders are not equal', () {
        final other = Statistics(totalNumberOfOrders: 99, finishedOrders: 5);
        expect(statistics == other, false);
      });
      test('objects with different finishedOrders are not equal', () {
        final other = Statistics(totalNumberOfOrders: 10, finishedOrders: 99);
        expect(statistics == other, false);
      });
      test('objects with both fields different are not equal', () {
        final other = Statistics(totalNumberOfOrders: 1, finishedOrders: 1);
        expect(statistics == other, false);
      });
    });
  });
}