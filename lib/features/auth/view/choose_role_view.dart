import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/choose_role_body.dart';

class ChooseRoleView extends StatelessWidget {
  const ChooseRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ChooseRoleBody());
  }
}
