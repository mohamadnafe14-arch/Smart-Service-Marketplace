import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/choose_role_body.dart';

class ChooseRoleView extends StatelessWidget {
  const ChooseRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: ChooseRoleBody()));
  }
}
