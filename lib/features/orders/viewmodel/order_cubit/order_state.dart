part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  final List<PaginationLink> pagination;
  OrderLoaded({required this.orders, required this.pagination});
}

final class OrderError extends OrderState {
  final String message;
  OrderError({required this.message});
}
