import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/category_list.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_card.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_list.dart';

class TestingView extends StatelessWidget {
  const TestingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
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
        ),
      ),
    );
  }
}
