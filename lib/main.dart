import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/utils/service_locator.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/cubit/auth_cubit.dart';

void main() {
  setupServiceLocator();
  runApp(const SmartServiceMarketPlace());
}

class SmartServiceMarketPlace extends StatelessWidget {
  const SmartServiceMarketPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.route,
        ),
      ),
    );
  }
}
