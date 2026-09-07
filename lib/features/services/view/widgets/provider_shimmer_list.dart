import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card_shimmer.dart';

class ProviderShimmerList extends StatelessWidget {
  const ProviderShimmerList({super.key, this.itemCount = 5});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return const ProviderCardShimmer();
      },
    );
  }
}
