import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/provider_information_body.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';

class CustomProviderDrawer extends StatefulWidget {
  const CustomProviderDrawer({super.key, required this.token});
  final String token;
  @override
  State<CustomProviderDrawer> createState() => _CustomProviderDrawerState();
}

class _CustomProviderDrawerState extends State<CustomProviderDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ProviderInformationBody(
        token: widget.token,
        userInformation: UserInformation(
          name: "name",
          id: 1,
          email: "email",
          phone: "phone",
          createdSince: "createdSince",
          address: Address(
            city: "city",
            street: "street",
            addressInDetails: "addressInDetails",
            
          ),
          statistics: Statistics(totalNumberOfOrders: 0, finishedOrders: 0),
          rating: Rating(rate: 0, count: 0),
        ),
      ),
    );
  }
}
