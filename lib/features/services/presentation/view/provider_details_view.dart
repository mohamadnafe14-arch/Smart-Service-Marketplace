import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';

class ProviderDetailsView extends StatelessWidget {
  const ProviderDetailsView({super.key, required this.userInformation});
  final UserInformation userInformation;
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold());
  }
}
