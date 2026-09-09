import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/services/dio_service.dart';
import 'package:smart_service_market_place/features/orders/model/repos/order_repo_imple.dart';

class MockDioService extends Mock implements DioService {}

void main() {
  late MockDioService mockDioService;
  late OrderRepoImple repository;

  setUp(() {
    mockDioService = MockDioService();
    repository = OrderRepoImple(mockDioService);
  });

  const token = 'test-token';
  const headers = {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Response<dynamic> response({required int statusCode, required dynamic data}) {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: 'orders'),
      statusCode: statusCode,
      data: data,
    );
  }

  final orderData = {
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

  group('getOrders', () {
    test('returns decoded orders and sends pagination and auth data', () async {
      when(
        () => mockDioService.get(
          path: 'orders',
          queryParameters: {'page': 2},
          headers: headers,
        ),
      ).thenAnswer(
        (_) async => response(
          statusCode: 200,
          data: {
            'data': {
              'orders': [orderData],
            },
            'pagination': [],
          },
        ),
      );

      final result = await repository.getOrders(token: token, page: 2);

      expect(result.isRight(), isTrue);
      result.match(
        (failure) => fail('Expected a successful result: ${failure.message}'),
        (orders) {
          expect(orders.orders, hasLength(1));
          expect(orders.orders.single.id, 10);
          expect(orders.orders.single.status, 'pending');
        },
      );
      verify(
        () => mockDioService.get(
          path: 'orders',
          queryParameters: {'page': 2},
          headers: headers,
        ),
      ).called(1);
    });

    test('returns Failure when the response status is not 200', () async {
      when(
        () => mockDioService.get(
          path: 'orders',
          queryParameters: {'page': 1},
          headers: headers,
        ),
      ).thenAnswer(
        (_) async =>
            response(statusCode: 401, data: {'message': 'Unauthorized'}),
      );

      final result = await repository.getOrders(token: token, page: 1);

      result.match(
        (failure) => expect(failure.message, 'Unauthorized'),
        (_) => fail('Expected a failed result'),
      );
    });

    test('returns ServerFailuer for DioException', () async {
      when(
        () => mockDioService.get(
          path: 'orders',
          queryParameters: {'page': 1},
          headers: headers,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'orders'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await repository.getOrders(token: token, page: 1);

      result.match(
        (failure) => expect(failure.message, 'Connection timeout with server'),
        (_) => fail('Expected a failed result'),
      );
    });

    test('returns a generic Failure for unexpected exceptions', () async {
      when(
        () => mockDioService.get(
          path: 'orders',
          queryParameters: {'page': 1},
          headers: headers,
        ),
      ).thenThrow(Exception('boom'));

      final result = await repository.getOrders(token: token, page: 1);

      result.match(
        (failure) => expect(failure.message, 'An unexpected error occurred'),
        (_) => fail('Expected a failed result'),
      );
    });
  });

  group('updateOrder', () {
    const orderId = '10';
    const status = 'completed';
    const updatePath = 'order/update-status/$orderId';

    test('returns the server message and sends the update body', () async {
      when(
        () => mockDioService.put(
          path: updatePath,
          headers: headers,
          body: {'status': status},
        ),
      ).thenAnswer(
        (_) async => response(statusCode: 200, data: {'message': 'Updated'}),
      );

      final result = await repository.updateOrder(
        token: token,
        status: status,
        orderId: orderId,
      );

      result.match(
        (_) => fail('Expected a successful result'),
        (message) => expect(message, 'Updated'),
      );
      verify(
        () => mockDioService.put(
          path: updatePath,
          headers: headers,
          body: {'status': status},
        ),
      ).called(1);
    });

    test('returns Failure when the update response is not 200', () async {
      when(
        () => mockDioService.put(
          path: updatePath,
          headers: headers,
          body: {'status': status},
        ),
      ).thenAnswer(
        (_) async =>
            response(statusCode: 422, data: {'message': 'Invalid status'}),
      );

      final result = await repository.updateOrder(
        token: token,
        status: status,
        orderId: orderId,
      );

      result.match(
        (failure) => expect(failure.message, 'Invalid status'),
        (_) => fail('Expected a failed result'),
      );
    });

    test('returns ServerFailuer for DioException', () async {
      when(
        () => mockDioService.put(
          path: updatePath,
          headers: headers,
          body: {'status': status},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: updatePath),
          type: DioExceptionType.connectionError,
        ),
      );

      final result = await repository.updateOrder(
        token: token,
        status: status,
        orderId: orderId,
      );

      result.match(
        (failure) => expect(failure.message, 'No internet connection'),
        (_) => fail('Expected a failed result'),
      );
    });

    test('returns a generic Failure for unexpected exceptions', () async {
      when(
        () => mockDioService.put(
          path: updatePath,
          headers: headers,
          body: {'status': status},
        ),
      ).thenThrow(Exception('boom'));

      final result = await repository.updateOrder(
        token: token,
        status: status,
        orderId: orderId,
      );

      result.match(
        (failure) => expect(failure.message, 'An unexpected error occurred'),
        (_) => fail('Expected a failed result'),
      );
    });
  });
}
