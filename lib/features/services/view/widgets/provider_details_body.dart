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
import 'package:smart_service_market_place/features/services/viewmodel/get_provider_details_cubit/get_provider_details_cubit.dart';

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
                        phone:
                            userInformation.phone ?? "لم يتم ادخال رقم الهاتف",
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
