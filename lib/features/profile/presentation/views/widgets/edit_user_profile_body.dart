import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/functions/show_snack_bar.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';

class EditUserProfileBody extends StatefulWidget {
  const EditUserProfileBody({super.key});

  @override
  State<EditUserProfileBody> createState() => _EditUserProfileBodyState();
}

class _EditUserProfileBodyState extends State<EditUserProfileBody> {
  final formKey = GlobalKey<FormState>();
  String? name, phone, city, street, addressInDetails;
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
            Row(
              children: [
                Expanded(
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        GoRouter.of(context).go(AppRouter.userHomeRoute);
                      } else if (state is AuthError) {
                        showSnackBar(context: context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {}
                        },
                        text: "حفظ التغييرات",
                        isLoading: isLoading,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
