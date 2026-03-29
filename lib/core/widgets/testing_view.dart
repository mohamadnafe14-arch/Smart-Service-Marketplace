import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/core/functions/show_error_snack_bar.dart';

class TestingView extends StatefulWidget {
  const TestingView({super.key});

  @override
  State<TestingView> createState() => _TestingViewState();
}

class _TestingViewState extends State<TestingView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showErrorToast(context: context, message: "failed!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: Center(child: Text("Testing View"))),
    );
  }
}
