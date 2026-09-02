import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/edit_provider_profile_body.dart';
class EditProviderProfileView extends StatelessWidget {
  const EditProviderProfileView({super.key, required this.token});
  final String token;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تعديل الملف الشخصي"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: EditProviderProfileBody(token: token),
      ),
    );
  }
}