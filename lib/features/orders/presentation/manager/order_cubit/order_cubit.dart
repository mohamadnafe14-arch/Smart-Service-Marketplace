import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/core/secret/pusher_consts.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_model.dart';
import 'package:smart_service_marketplace/features/orders/data/repo/order_repo.dart';
import 'dart:convert';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final String token;
  final PusherChannelsFlutter pusher;
  final String role;
  final OrderRepo orderRepo;
  final String id;

  OrderCubit({
    required this.token,
    required this.pusher,
    required this.role,
    required this.orderRepo,
    required this.id,
  }) : super(OrderInitial());

  int currentPage = 1;
  bool _isPusherInitialized = false;
  final List<OrderModel> _pendingOrders = [];

  Future<void> initPusher() async {
    if (_isPusherInitialized) return;
    _isPusherInitialized = true;

    await pusher.init(
      apiKey: kPusherKey,
      cluster: kPusherCluster,
      onEvent: (event) => _handleEvent(event),
    );

    await pusher.connect();
    await pusher.subscribe(channelName: "$role.$id");
  }

  void _handleEvent(PusherEvent event) {
    if (isClosed) return;
    try {
      final decoded = jsonDecode(event.data);
      debugPrint("decoded event data: $decoded");
      final data = decoded['order'] ?? decoded;
      if (state is! OrderLoaded) {
        if (event.eventName == "order.created" ||
            event.eventName == ".order.created") {
          final newOrder = OrderModel.fromJson(data);
          final exists = _pendingOrders.any((o) => o.id == newOrder.id);
          if (!exists) _pendingOrders.add(newOrder);
        }
        return;
      }

      final currentState = state as OrderLoaded;
      final currentOrders = List<OrderModel>.from(currentState.orders);

      if (event.eventName == "order.created" ||
          event.eventName == ".order.created") {
        final newOrder = OrderModel.fromJson(data);
        if (!currentOrders.any((o) => o.id == newOrder.id)) {
          currentOrders.insert(0, newOrder);
          emit(
            OrderLoaded(
              orders: currentOrders,
              pagination: currentState.pagination,
            ),
          );
        }
      } else if (event.eventName == "order.updated") {
        final updatedOrder = OrderModel.fromJson(data);
        final index = currentOrders.indexWhere((o) => o.id == updatedOrder.id);
        if (index != -1) {
          currentOrders[index] = updatedOrder;
          emit(
            OrderLoaded(
              orders: currentOrders,
              pagination: currentState.pagination,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Pusher event error: $e");
    }
  }

  void changePage(int page) {
    currentPage = page;
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    emit(OrderLoading());

    final result = await orderRepo.getOrders(token: token, page: currentPage);

    result.fold((failure) => emit(OrderError(message: failure.message)), (
      response,
    ) {
      final orders = List<OrderModel>.from(response.orders);
      for (var order in _pendingOrders) {
        final exists = orders.any((o) => o.id == order.id);
        if (!exists) {
          orders.insert(0, order);
        }
      }
      _pendingOrders.clear();
      emit(OrderLoaded(orders: orders, pagination: response.pagination));
    });
  }

  @override
  Future<void> close() {
    pusher.unsubscribe(channelName: "$role.$id");
    pusher.disconnect();
    return super.close();
  }

  Future<void> init() async {
    await initPusher();
    await fetchOrders();
  }
}
