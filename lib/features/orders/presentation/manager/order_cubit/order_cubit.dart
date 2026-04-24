

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_response_model.dart';
import 'package:smart_service_marketplace/features/orders/data/repo/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final String token;
  final OrderRepo orderRepo;

  OrderCubit({required this.token, required this.orderRepo}) : super(OrderInitial());
  int currentPage = 1;
  void changePage(int page) {
    currentPage = page;
    fetchOrders();
  }
  Future<void> fetchOrders() async {
    emit(OrderLoading());
    final result = await orderRepo.getOrders(token: token, page: currentPage);
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (response) => emit(OrderLoaded(orderResponseModel: response)),
    );
  }
}
