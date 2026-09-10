import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_cubit_params.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_model.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_response_model.dart';
import 'package:smart_service_market_place/features/orders/model/repos/order_repo.dart';
import 'package:smart_service_market_place/features/orders/viewmodel/order_cubit/order_cubit.dart';

class MockOrderRepo extends Mock implements OrderRepo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockOrderRepo mockOrderRepo;
  late OrderCubit orderCubit;

  final params = OrderCubitParams(
    token: 'test-token',
    id: 'user-1',
    role: 'user',
  );
  final order = OrderModel(
    status: 'pending',
    phoneUser: '01000000000',
    providerName: 'Test Provider',
    description: 'Fix the sink',
    userName: 'Test User',
    updatedAt: '2024-01-01T12:00:00Z',
    rating: 4.5,
    userId: 1,
    providerId: 2,
    id: 10,
  );
  final response = OrderResponseModel(orders: [order], pagination: []);
  final failure = Failure(message: 'Unable to load orders');

  setUp(() {
    mockOrderRepo = MockOrderRepo();
    orderCubit = OrderCubit(orderCubitParams: params, orderRepo: mockOrderRepo);
  });

  tearDown(() => orderCubit.close());

  test('starts in OrderInitial state', () {
    expect(orderCubit.state, isA<OrderInitial>());
  });

  group('fetchOrders', () {
    blocTest<OrderCubit, OrderState>(
      'emits loading and loaded states when the request succeeds',
      build: () {
        when(
          () => mockOrderRepo.getOrders(token: params.token, page: 1),
        ).thenAnswer((_) async => Right<Failure, OrderResponseModel>(response));
        return orderCubit;
      },
      act: (cubit) => cubit.fetchOrders(),
      expect: () => [
        isA<OrderLoading>(),
        isA<OrderLoaded>()
            .having((state) => state.orders, 'orders', [order])
            .having((state) => state.pagination, 'pagination', isEmpty),
      ],
      verify: (_) {
        verify(
          () => mockOrderRepo.getOrders(token: params.token, page: 1),
        ).called(1);
      },
    );

    blocTest<OrderCubit, OrderState>(
      'emits loading and error states when the request fails',
      build: () {
        when(
          () => mockOrderRepo.getOrders(token: params.token, page: 1),
        ).thenAnswer((_) async => Left<Failure, OrderResponseModel>(failure));
        return orderCubit;
      },
      act: (cubit) => cubit.fetchOrders(),
      expect: () => [
        isA<OrderLoading>(),
        isA<OrderError>().having(
          (state) => state.message,
          'message',
          failure.message,
        ),
      ],
    );
  });

  test('changePage updates the page and fetches that page', () async {
    when(
      () => mockOrderRepo.getOrders(token: params.token, page: 2),
    ).thenAnswer((_) async => Right<Failure, OrderResponseModel>(response));

    orderCubit.changePage(2);
    await untilCalled(
      () => mockOrderRepo.getOrders(token: params.token, page: 2),
    );

    expect(orderCubit.currentPage, 2);
    verify(
      () => mockOrderRepo.getOrders(token: params.token, page: 2),
    ).called(1);
  });

  test('updateOrderStatus delegates to the repository', () async {
    when(
      () => mockOrderRepo.updateOrder(
        token: params.token,
        status: 'completed',
        orderId: '10',
      ),
    ).thenAnswer((_) async => const Right<Failure, String>('Updated'));

    await orderCubit.updateOrderStatus(status: 'completed', orderId: '10');

    verify(
      () => mockOrderRepo.updateOrder(
        token: params.token,
        status: 'completed',
        orderId: '10',
      ),
    ).called(1);
  });
}
