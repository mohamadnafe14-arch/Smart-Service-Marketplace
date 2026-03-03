import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/edit_user_profile_body.dart';

class EditUserProfileView extends StatelessWidget {
  const EditUserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تعديل الملف الشخصي"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: EditUserProfileBody(),
      ),
    );
  }
}
