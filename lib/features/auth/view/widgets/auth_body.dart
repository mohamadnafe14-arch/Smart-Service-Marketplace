import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/auth/view/widgets/custom_auth_button.dart';
import 'package:smart_service_marketplace/features/auth/view/widgets/custom_text_form_field.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  bool signIn = true;
  bool signUp = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          SizedBox(height: 50.h),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Icon(Icons.lock, size: 75.sp, color: Colors.blue),
          ),
          SizedBox(height: 20.h),
          const Text(
            "مرحبا بك في سوق الخدمات الرقمية",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          const Text(
            "يرجي ادخال بياناتك بعناية",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomAuthButton(
                  text: "انشاء حساب",
                  isActive: signUp,
                  onPressed: () {
                    setState(() {
                      signIn = false;
                      signUp = true;
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomAuthButton(
                  text: "تسجيل الدخول",
                  isActive: signIn,
                  onPressed: () {
                    setState(() {
                      signIn = true;
                      signUp = false;
                    });
                  },
                ),
              ),
            ],
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
        ],
      ),
    );
  }
}
