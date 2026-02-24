import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/custom_text_form_field.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
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
                return null;
              },
              onSaved: (value) {},
              onChanged: (value) {},
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
              onSaved: (value) {},
              onChanged: (value) {},
              icon: Icons.lock,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {}
                    },
                    text: "ابدأ الان",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.forgotPasswordRoute);
              },
              child: Text(
                "نسيت كلمة المرور؟",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
