import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/utils/service_locator.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/profile/data/repo/profile_repo.dart';
import 'package:smart_service_marketplace/features/profile/presentation/manager/cubit/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
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
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) =>
                AuthCubit(authRepo: getIt<AuthRepo>()),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(getIt<ProfileRepo>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.route,
        ),
      ),
    );
  }
}
