import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/view/widgets/splash_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: SplashBody()));
  }
}
