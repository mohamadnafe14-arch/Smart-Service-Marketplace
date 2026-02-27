import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/role_card.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';

class ChooseRoleBody extends StatefulWidget {
  const ChooseRoleBody({super.key});
  @override
  State<ChooseRoleBody> createState() => _ChooseRoleBodyState();
}

class _ChooseRoleBodyState extends State<ChooseRoleBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: fadeAnimation,
            child: const Column(
              children: [
                Text(
                  "مرحبًا بك 👋",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "منصة تربط بين المستخدمين ومقدمي الخدمات الرقمية بسهولة وأمان.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          RoleCard(
            title: "مستخدم",
            description: "اطلب خدماتك بسهولة من أفضل مقدمي الخدمات.",
            icon: Icons.person,
            fadeAnimation: fadeAnimation,
            slideAnimation: slideAnimation,
            onTap: () {
              BlocProvider.of<AuthCubit>(context).setRole("user");
              GoRouter.of(context).push(AppRouter.authRoute);
            },
          ),
          RoleCard(
            title: "مقدم خدمة",
            description: "اعرض خدماتك وابدأ في تحقيق أرباح.",
            icon: Icons.work,
            fadeAnimation: fadeAnimation,
            slideAnimation: slideAnimation,
            onTap: () {
              BlocProvider.of<AuthCubit>(context).setRole("provider");
              GoRouter.of(context).push(AppRouter.authRoute);
            },
          ),
        ],
      ),
    );
  }
}
