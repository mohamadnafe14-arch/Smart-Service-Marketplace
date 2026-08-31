import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/user_information_body.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';

class CustomUserDrawer extends StatefulWidget {
  const CustomUserDrawer({super.key, required this.token});
  final String token;
  @override
  State<CustomUserDrawer> createState() => _CustomUserDrawerState();
}

class _CustomUserDrawerState extends State<CustomUserDrawer> {
  @override
  void initState() {
    //TODO: Add fetch user information
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: UserInformatioBody(
        userInformation: UserInformation(
          name: "name",
          id: 1,
          email: "email",
          createdSince: "createdSince",
          address: Address(
            city: "city",
            street: "street",
            addressInDetails: "addressInDetails",
          ),
          statistics: Statistics(totalNumberOfOrders: 0, finishedOrders: 0),
          rating: Rating(rate: 0, count: 0),
          category: "category",
          experience: "experience",
        ),
        token: widget.token,
        isShrinked: true,
      ),
    );
  }
}
