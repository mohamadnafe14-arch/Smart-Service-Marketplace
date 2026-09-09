import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/core/widgets/pagination_widget.dart';
import 'package:smart_service_market_place/features/orders/model/order_model.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/user_card.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      //ToDo: WRITE  the business logic
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return UserCard(
                order: OrderModel(
                  providerName: 'Ahmed Services',
                  status: 'active',
                  description: 'AC repair and maintenance',
                  updatedAt: '2025-01-01',
                  id: 1,
                  userId: 1,
                  providerId: 1,
                  phoneUser: '01000000000',
                  userName: 'John Doe',
                  rating: 4.5,
                ),
              );
            },
          ),
          PaginationWidget(
            links: [
              PaginationLink(label: '1', url: null, active: true),
              PaginationLink(label: '2', url: null, active: false),
              PaginationLink(label: '3', url: null, active: false),
            ],
            onPageSelected: (page) => () {},
          ),
        ],
      ),
    );
  }
}
