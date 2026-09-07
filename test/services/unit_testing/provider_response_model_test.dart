import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/features/services/model/models/get_provider.dart';
import 'package:smart_service_market_place/features/services/model/models/provider_response_model.dart';

void main() {
  group('ProviderResponseModel', () {
    final provider = GetProvider(
      id: 1,
      name: 'John Doe',
      role: 'plumber',
      phone: '01000000000',
      category: 'maintenance',
      rating: 5,
    );
    final paginationLink = PaginationLink(
      url: 'https://example.com/providers?page=2',
      label: 'Next',
      active: false,
    );
    final response = ProviderResponseModel(
      providers: [provider],
      pagination: [paginationLink],
    );

    test('constructor assigns providers and pagination', () {
      expect(response.providers, [provider]);
      expect(response.pagination, [paginationLink]);
    });

    group('copyWith', () {
      test('returns an equivalent copy when no values are provided', () {
        expect(response.copyWith(), response);
      });

      test('replaces only the provided fields', () {
        final replacementProvider = GetProvider(id: 2, name: 'Jane Doe');
        final replacementLink = PaginationLink(
          label: 'Previous',
          active: false,
        );

        final result = response.copyWith(
          providers: [replacementProvider],
          pagination: [replacementLink],
        );

        expect(result.providers, [replacementProvider]);
        expect(result.pagination, [replacementLink]);
      });
    });

    group('map and JSON serialization', () {
      test('toMap serializes nested models', () {
        expect(response.toMap(), {
          'providers': [provider.toMap()],
          'pagination': [paginationLink.toMap()],
        });
      });

      test('fromMap reconstructs nested models', () {
        expect(ProviderResponseModel.fromMap(response.toMap()), response);
      });

      test('toJson and fromJson preserve the response', () {
        expect(ProviderResponseModel.fromJson(response.toJson()), response);
      });
    });

    test('toString includes both collections', () {
      final value = response.toString();

      expect(value, contains('ProviderResponseModel'));
      expect(value, contains(provider.toString()));
      expect(value, contains(paginationLink.toString()));
    });

    group('equality and hashCode', () {
      test('equal responses have equal hash codes', () {
        final other = ProviderResponseModel(
          providers: [provider],
          pagination: [paginationLink],
        );

        expect(response, other);
        expect(response.hashCode, other.hashCode);
      });

      test('responses with different providers are not equal', () {
        final other = response.copyWith(
          providers: [provider.copyWith(name: 'Different')],
        );

        expect(response == other, isFalse);
      });

      test('identical instance is equal to itself', () {
        expect(response == response, isTrue);
      });
    });
  });
}
