import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/custom_progress_bar.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/three_dots.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});
  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  @override
  void initState() {
    super.initState();
    animationPreparation();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    navigateToNextPage();
  });  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                  height: 180.h,
                ),
                SizedBox(height: 25.h),
                Text(
                  "سوق الخدمات الرقمية",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "منصة الخدمات المصغرة الذكية",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white70),
                ),
                SizedBox(height: 40.h),
                Text(
                  "جاري تهيئة المنصة...",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(height: 10.h),
                CustomProgressBar(animation: animation),
                SizedBox(height: 25.h),
                ThreeDots(animation: animation),
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToNextPage() {
    Future.wait([
      Future.delayed(const Duration(seconds: 5)),
      context.read<AuthCubit>().getCurrentUser(),
    ]).then((_) {
      if (!mounted) return;
      final state = context.read<AuthCubit>().state;
      if (state is AuthSuccess) {
        context.go(AppRouter.homeRoute);
      } else {
        context.go(AppRouter.chooseRoleRoute);
      }
    });
  }

  void animationPreparation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.forward();
  }
}
