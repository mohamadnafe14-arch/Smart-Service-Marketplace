import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/request_card.dart';

class TestingView extends StatelessWidget {
  const TestingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pusher Test")),
      body: RequestCard(
        status: "pending",
        userName: "Ahmed",
        phone: "0123456789",
        description: "nothing",
        updatedAt: "2024-06-01",
      ),
    );
  }
}
