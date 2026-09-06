import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_market_place/core/widgets/custom_button.dart';
import 'package:smart_service_market_place/core/widgets/provider_information_widget.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/services/model/models/make_order_param.dart';
import 'package:smart_service_market_place/features/services/view/widgets/make_order_dialog.dart';

class ProviderDetailsBody extends StatelessWidget {
  const ProviderDetailsBody({super.key, required this.providerInformation});
  final UserInformation providerInformation;
  @override
  Widget build(BuildContext context) {
    final rootContext = context;
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      child: Column(
        children: [
          ProviderInformationWidget(userInformation: providerInformation),
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  final user =
                      (BlocProvider.of<AuthCubit>(context).state as AuthSuccess)
                          .user;
                          //TODO get the provider id from the providerInformation object and pass it to the MakeOrderDialog                  
                  return MakeOrderDialog(
                    makeOrderParam: MakeOrderParam(
                      providerId: "",
                      token: user.token,
                      phone: "",
                      pop: () {
                        rootContext.pop();
                      },
                    ),
                  );
                },
              );
            },
            text: "عمل اوردر",
          ),
        ],
      ),
    );
  }
}
