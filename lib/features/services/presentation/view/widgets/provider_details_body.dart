import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/core/widgets/provider_information_widget.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/data/models/make_order_param.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/get_provider_details_cubit/get_provider_details_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/make_order_dialog.dart';

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
                  final UserInformation userInformation =
                      (BlocProvider.of<GetProviderDetailsCubit>(context).state
                              as GetProviderDetailsLoaded)
                          .userInformation;
                  return BlocProvider.value(
                    value: rootContext.read<GetProviderDetailsCubit>(),
                    child: MakeOrderDialog(
                      makeOrderParam: MakeOrderParam(
                        providerId: userInformation.id.toString(),
                        token: user.token,
                        phone: userInformation.phone,
                        pop: () {
                          rootContext.pop();
                        },
                      ),
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
