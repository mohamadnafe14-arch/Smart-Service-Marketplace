import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_card.dart';

class ProviderList extends StatelessWidget {
  const ProviderList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => ProviderCard(
        userInformation: UserInformation.fromJson({"category": "السباكة"}),
      ),
      itemCount: 10,
    );
  }
}
