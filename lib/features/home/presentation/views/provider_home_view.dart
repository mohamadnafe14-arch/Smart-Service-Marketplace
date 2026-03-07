import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/custom_provider_drawer.dart';

class ProviderHomeView extends StatelessWidget {
  const ProviderHomeView({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomProviderDrawer(token: user.token),
      ),
    );
  }
}
