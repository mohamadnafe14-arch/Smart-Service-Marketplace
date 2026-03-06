import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/custom_user_drawer.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(), drawer: CustomUserDrawer()),
    );
  }
}
