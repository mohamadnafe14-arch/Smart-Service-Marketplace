import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/auth_body.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: AuthBody()),
    );
  }
}