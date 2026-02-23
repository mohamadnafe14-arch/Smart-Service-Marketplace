import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';

void main() {
  runApp(const SmartServiceMarketPlace());
}

class SmartServiceMarketPlace extends StatelessWidget {
  const SmartServiceMarketPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.route,
      ),
    );
  }
}
