import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/edit_provider_profile_body.dart';

class EditProviderProfileView extends StatelessWidget {
  const EditProviderProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تعديل الملف الشخصي"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: EditProviderProfileBody(),
      ),
    );
  }
}
