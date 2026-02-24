import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/otp_code_body.dart';

class OtpCodeView extends StatelessWidget {
  const OtpCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(), body: OtpCodeBody()),
    );
  }
}
