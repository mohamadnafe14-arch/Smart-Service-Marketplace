import 'package:flutter/material.dart';

import 'package:smart_service_marketplace/features/services/presentation/view/widgets/services_body.dart';

class TestingView extends StatelessWidget {
  const TestingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ServicesBody(),
      ),
    );
  }
}


