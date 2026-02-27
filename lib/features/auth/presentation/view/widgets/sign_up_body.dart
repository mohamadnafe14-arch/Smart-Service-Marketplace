import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/functions/show_snack_bar.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/different_forms_login_or_register.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? name, email, password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "الاسم بالكامل",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              hintText: "ادخل الاسم بالكامل",
              validator: (value) {
                if (value!.isEmpty) {
                  return "الاسم بالكامل مطلوب";
                }
                return null;
              },
              onSaved: (value) {
                name = value;
              },
              onChanged: (value) {
                name = value;
              },
              icon: Icons.person,
            ),
            SizedBox(height: 10.h),
            Text(
              "البريد الالكتروني",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              hintText: "example@gmail.com",
              validator: (value) {
                if (value!.isEmpty) {
                  return "يرجي ادخال البريد الالكتروني";
                }
                if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                ).hasMatch(value)) {
                  return "يرجي ادخال بريد الالكتروني صحيح";
                }
                if (!value.endsWith(".spm")) {
                  return "يرجي ادحال بريد ينتهي ب'.spm'";
                }
                return null;
              },
              onSaved: (value) {
                email = value;
              },
              onChanged: (value) {
                email = value;
              },
              icon: Icons.email,
            ),
            SizedBox(height: 10.h),
            Text(
              "كلمة المرور",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              hintText: "ادخل كلمة المرور",
              isPassword: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "يرجي ادخال كلمة المرور";
                }
                return null;
              },
              onSaved: (value) {
                password = value;
              },
              onChanged: (value) {
                password = value;
              },
              icon: Icons.lock,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        GoRouter.of(context).go(AppRouter.homeRoute);
                      } else if (state is AuthError) {
                        showSnackBar(context: context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await context.read<AuthCubit>().register(
                              name: name!,
                              email: email!,
                              password: password!,
                            );
                          }
                        },
                        text: "ابدأ الان",
                        isLoading: isLoading,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey, thickness: 4.w),
                ),
                Text("يمكنك ايضا المتابعة باستخدام"),
                Expanded(
                  child: Divider(color: Colors.grey, thickness: 4.w),
                ),
              ],
            ),
            DifferentFormsLoginOrRegister(googleAuth: () {}, githubAuth: () {}),
          ],
        ),
      ),
    );
  }
}
