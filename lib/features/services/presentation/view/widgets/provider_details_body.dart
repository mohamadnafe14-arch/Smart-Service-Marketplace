import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/core/widgets/provider_information_widget.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';

class ProviderDetailsBody extends StatelessWidget {
  const ProviderDetailsBody({super.key, required this.userInformation});
  final UserInformation userInformation;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      child: Column(
        children: [
          ProviderInformationWidget(userInformation: userInformation),
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () {
              
            },
            text: "عمل اوردر",
          ),
        ],
      ),
    );
  }
}
