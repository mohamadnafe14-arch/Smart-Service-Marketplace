import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/request_card_shimmer.dart';

class RequestShimmerList extends StatelessWidget {
  const RequestShimmerList({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const RequestCardShimmer();
      },
    );
  }
}
