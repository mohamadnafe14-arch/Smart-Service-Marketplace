import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/features/auth/view/splash_view.dart';

void main() {
  runApp(const SmartServiceMarketPlaceApp());
}

class SmartServiceMarketPlaceApp extends StatelessWidget {
  const SmartServiceMarketPlaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
