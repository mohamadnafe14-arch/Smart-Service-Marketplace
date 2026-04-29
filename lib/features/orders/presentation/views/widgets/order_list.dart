import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/orders/presentation/manager/order_cubit/order_cubit.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/request_card.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/user_card.dart';
import 'package:smart_service_marketplace/core/widgets/pagination_widget.dart';
class OrderList extends StatelessWidget {
  const OrderList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is OrderError) {
          return SliverFillRemaining(child: Center(child: Text(state.message)));
        }
        if (state is OrderLoaded && state.orders.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final String role =
                        (BlocProvider.of<AuthCubit>(context).state
                                as AuthSuccess)
                            .user
                            .role;
                    return role == "user"
                        ? UserCard(order: state.orders[index])
                        : RequestCard(order: state.orders[index]);
                  },
                ),
                PaginationWidget(
                  links: state.pagination,
                  onPageSelected: (page) =>
                      context.read<OrderCubit>().changePage(page),
                ),
              ],
            ),
          );
        }
        if (state is OrderLoaded && state.orders.isEmpty) {
          return const SliverFillRemaining(
            child: Center(
              child: Text(
                "لا يوجد طلبات",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}