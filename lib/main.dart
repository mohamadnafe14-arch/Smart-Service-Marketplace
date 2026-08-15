import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/splash/view/splash_view.dart';

void main() {
  runApp(const SmartServiceMarketPlaceApp());
}

class SmartServiceMarketPlaceApp extends StatelessWidget {
  const SmartServiceMarketPlaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) =>
          MaterialApp(debugShowCheckedModeBanner: false, home: SplashView()),
    );
  }
}
