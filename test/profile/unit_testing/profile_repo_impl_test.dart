import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_update.dart';
import 'package:smart_service_market_place/features/profile/model/repos/profile_repo_impl.dart';

class MockDioService extends Mock implements DioService {}

// fake for registerFallbackValue if needed for maps/paths
class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockDioService mockDioService;
  late ProfileRepoImpl repo;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDioService = MockDioService();
    repo = ProfileRepoImpl(mockDioService);
  });

  const token = 'test_token';

  final expectedHeaders = {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Response<T> buildResponse<T>({
    required int statusCode,
    required T data,
    String path = 'api/profile',
  }) {
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: statusCode,
      data: data,
    );
  }

  group('getUserInformation', () {
    final user = UserInformation(
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      phone: '1234567890',
      createdSince: '2022-01-01',
      address: Address(
        city: 'Sample City',
        street: 'Sample Street',
        addressInDetails: 'Apartment 101',
      ),
      statistics: Statistics(finishedOrders: 1, totalNumberOfOrders: 5),
      rating: Rating(rate: 4.5, count: 10),
      category: 'Plumber',
      experiences: '5 years',
    );
    final userJson = user.toMap();

    test('returns Right(UserInformation) on 200 response', () async {
      final responseData = {
        'data': {'user': userJson},
      };

      when(
        () => mockDioService.get(
          path: 'api/profile',
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 200, data: responseData),
      );

      final result = await repo.getUserInformation(token: token);

      expect(result.isRight(), true);
      result.match((l) {
        log('Error: ${l.message}');
        fail('Expected Right, got Left');
      }, (r) => expect(r, isA<UserInformation>()));

      final captured = verify(
        () => mockDioService.get(
          path: 'api/profile',
          headers: captureAny(named: 'headers'),
        ),
      ).captured;
      expect(captured.first, expectedHeaders);
    });

    test('returns Left(Failure) with message on non-200 response', () async {
      final responseData = {'message': 'Not authorized'};

      when(
        () => mockDioService.get(
          path: 'api/profile',
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 401, data: responseData),
      );

      final result = await repo.getUserInformation(token: token);

      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l.message, 'Not authorized'),
        (r) => fail('Expected Left, got Right'),
      );
    });

    test(
      'returns Left(Failure) with default message when message key missing',
      () async {
        when(
          () => mockDioService.get(
            path: 'api/profile',
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => buildResponse(statusCode: 400, data: {}));

        final result = await repo.getUserInformation(token: token);

        result.match(
          (l) => expect(l.message, 'Unknown error'),
          (r) => fail('Expected Left, got Right'),
        );
      },
    );

    test('returns Left(ServerFailure) when DioException is thrown', () async {
      when(
        () => mockDioService.get(
          path: 'api/profile',
          headers: any(named: 'headers'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'api/profile'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await repo.getUserInformation(token: token);

      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l, isA<Failure>()),
        (r) => fail('Expected Left, got Right'),
      );
    });

    test(
      'returns Left(Failure) when an unexpected exception is thrown',
      () async {
        when(
          () => mockDioService.get(
            path: 'api/profile',
            headers: any(named: 'headers'),
          ),
        ).thenThrow(Exception('boom'));

        final result = await repo.getUserInformation(token: token);

        expect(result.isLeft(), true);
        result.match(
          (l) => expect(l.message, contains('boom')),
          (r) => fail('Expected Left, got Right'),
        );
      },
    );
  });

  group('updateUserInformation', () {
    final userJson = {
      'id': '1',
      'name': 'Jane Doe',
      'email': 'jane@example.com',
    };

    final userUpdate = UserUpdate(
      // fill with actual required fields of your UserUpdate model
      name: 'Jane Doe',
    );

    test('returns Right(UserInformation) on 200 response', () async {
      final responseData = {
        'data': {'profile': userJson},
      };

      when(
        () => mockDioService.put(
          path: 'api/profile',
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 200, data: responseData),
      );

      final result = await repo.updateUserInformation(
        userUpdate: userUpdate,
        token: token,
      );

      expect(result.isRight(), true);
      result.match(
        (l) => fail('Expected Right, got Left: ${l.message}'),
        (r) => expect(r, isA<UserInformation>()),
      );

      verify(
        () => mockDioService.put(
          path: 'api/profile',
          headers: expectedHeaders,
          body: userUpdate.toMap(),
        ),
      ).called(1);
    });

    test('returns Left(Failure) with message on non-200 response', () async {
      final responseData = {'message': 'Validation failed'};

      when(
        () => mockDioService.put(
          path: 'api/profile',
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => buildResponse(statusCode: 422, data: responseData),
      );

      final result = await repo.updateUserInformation(
        userUpdate: userUpdate,
        token: token,
      );

      result.match(
        (l) => expect(l.message, 'Validation failed'),
        (r) => fail('Expected Left, got Right'),
      );
    });

    test('returns Left(ServerFailure) when DioException is thrown', () async {
      when(
        () => mockDioService.put(
          path: 'api/profile',
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'api/profile'),
          type: DioExceptionType.badResponse,
        ),
      );

      final result = await repo.updateUserInformation(
        userUpdate: userUpdate,
        token: token,
      );

      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l, isA<Failure>()),
        (r) => fail('Expected Left, got Right'),
      );
    });

    test(
      'returns Left(Failure) when an unexpected exception is thrown',
      () async {
        when(
          () => mockDioService.put(
            path: 'api/profile',
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenThrow(Exception('unexpected'));

        final result = await repo.updateUserInformation(
          userUpdate: userUpdate,
          token: token,
        );

        expect(result.isLeft(), true);
        result.match(
          (l) => expect(l.message, contains('unexpected')),
          (r) => fail('Expected Left, got Right'),
        );
      },
    );
  });
}
