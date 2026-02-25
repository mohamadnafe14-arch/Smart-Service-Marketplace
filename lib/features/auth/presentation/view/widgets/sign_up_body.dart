import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/constants/service_const.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/different_forms_login_or_register.dart';
import 'package:http/http.dart' as http;

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
                  child: CustomButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return; // ❗ وقف التنفيذ هنا
                      }

                      _formKey.currentState!.save();

                      try {
                        print("Name: $name");
                        print("Email: $email");
                        print("Password: $password");

                        final response = await http.post(
                          Uri.parse('http://26.180.92.230:8000/api/register'),
                          headers: {
                            'Content-Type': 'application/json',
                            "Accept": "application/json",
                          },
                          body: jsonEncode({
                            'email': email,
                            'password': password,
                            'name': name,
                          }),
                        );

                        print("Status Code: ${response.statusCode}");
                        print("Body: ${response.body}");

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(response.body)));
                      } catch (e) {
                        print("Error: $e");
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    text: "ابدأ الان",
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
