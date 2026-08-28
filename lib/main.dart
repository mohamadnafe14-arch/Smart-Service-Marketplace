import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/core/utils/dependecy_injection.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(const SmartServiceMarketPlaceApp());
}

class SmartServiceMarketPlaceApp extends StatelessWidget {
  const SmartServiceMarketPlaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
