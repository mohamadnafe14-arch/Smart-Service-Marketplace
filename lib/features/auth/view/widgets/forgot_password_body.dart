import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/auth/view/widgets/custom_text_form_field.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Text(
              "أدخل بريدك الالكتروني",
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
            CustomButton(
              onPressed: () {},
              text: "ارسال كود التحقق الي الايميل",
            ),
          ],
        ),
      ),
    );
  }
}
