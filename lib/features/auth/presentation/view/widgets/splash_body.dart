import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/custom_progress_bar.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/three_dots.dart';
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
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), 
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        GoRouter.of(context).go("/auth");
      }
    });
  }
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
              colors: [
                Color(0xff0f2027),
                Color(0xff203a43),
                Color(0xff2c5364),
              ],
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
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "جاري تهيئة المنصة...",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
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
}