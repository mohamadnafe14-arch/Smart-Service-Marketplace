import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/category_list.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_list.dart';

class ServicesBody extends StatelessWidget {
  const ServicesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            "الخدمات المتاحة الان التي يمكنك طلبها",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          pinned: true,
          floating: true,
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        SliverToBoxAdapter(child: CategoryList()),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ProviderList(),
      ],
    );
  }
}
