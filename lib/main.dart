import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';

void main() {
  runApp(const SmartServiceMarketPlace());
}

class SmartServiceMarketPlace extends StatelessWidget {
  const SmartServiceMarketPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.route,
    );
  }
}
