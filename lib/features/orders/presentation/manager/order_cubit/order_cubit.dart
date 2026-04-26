import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/models/pagination_link.dart';
import 'package:smart_service_marketplace/core/secret/pusher_consts.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_model.dart';
import 'package:smart_service_marketplace/features/orders/data/repo/order_repo.dart';
import 'package:http/http.dart' as http;
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
  List<OrderModel> _pendingOrders = [];
  Future<void> initPusher() async {
    if (_isPusherInitialized) return;
    _isPusherInitialized = true;
    await pusher.init(
      apiKey: kPusherKey,
      cluster: kPusherCluster,
      onEvent: (event) {
        _handleEvent(event);
      },
      onAuthorizer: (channelName, socketId, options) async {
        final response = await http.post(
          Uri.parse("${kBaseUrl}broadcasting/auth"),
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
          body: {"socket_id": socketId, "channel_name": channelName},
        );
        return jsonDecode(response.body);
      },
    );
    await pusher.connect();
    await pusher.subscribe(channelName: "private-$role.$id");
  }

  void _handleEvent(PusherEvent event) {
    if (state is! OrderLoaded) {
      final decoded = jsonDecode(event.data);
      final data = decoded['order'] ?? decoded;
      if (event.eventName.contains("OrderCreated")) {
        _pendingOrders.add(OrderModel.fromJson(data));
      }
      return;
    }
    final currentState = state as OrderLoaded;
    final List<OrderModel> currentOrders = List.from(currentState.orders);
    final decoded = jsonDecode(event.data);
    final data = decoded['order'] ?? decoded;
    if (event.eventName == "order.created" ||
        event.eventName == "OrderCreated") {
      final newOrder = OrderModel.fromJson(data);
      final exists = currentOrders.any((o) => o.id == newOrder.id);
      if (!exists) {
        currentOrders.insert(0, newOrder);
      }
      emit(
        OrderLoaded(orders: currentOrders, pagination: currentState.pagination),
      );
    }
    if (event.eventName == "order.updated") {
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
    pusher.unsubscribe(channelName: "private-$role.$id");
    pusher.disconnect();
    return super.close();
  }

  Future<void> init() async {
    await Future.wait([fetchOrders(), initPusher()]);
  }
}
