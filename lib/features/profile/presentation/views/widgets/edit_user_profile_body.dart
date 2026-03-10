import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/functions/show_snack_bar.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_update.dart';
import 'package:smart_service_marketplace/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/profile_text_form_field.dart';

class EditUserProfileBody extends StatefulWidget {
  const EditUserProfileBody({super.key, required this.token});
  final String token;
  @override
  State<EditUserProfileBody> createState() => _EditUserProfileBodyState();
}

class _EditUserProfileBodyState extends State<EditUserProfileBody> {
  final formKey = GlobalKey<FormState>();
  String? name, phone, city, street, addressInDetails;
  @override
  Widget build(BuildContext context) {
    final userInformation =
        (context.read<ProfileCubit>().state as ProfileSuccess).userInformation;
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
              "الاسم",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ProfileTextFormField(
              hintText: "ادخل الاسم بالكامل",
              initialValue: userInformation.name,
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
              "رقم الهاتف",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ProfileTextFormField(
              hintText: "ادخل رقم الهاتف",
              initialValue: userInformation.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return "رقم الهاتف مطلوب";
                }
                if (!RegExp(r"^01[0125][0-9]{8}$").hasMatch(value)) {
                  return "يرجي ادخال رقم هاتف صحيح";
                }
                return null;
              },
              onSaved: (value) {
                phone = value;
              },
              onChanged: (value) {
                phone = value;
              },
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10.h),
            Text(
              "المدينة",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ProfileTextFormField(
              hintText: "ادخل المدينة",
              initialValue: userInformation.address.city,
              validator: (value) {
                if (value!.isEmpty) {
                  return "المدينة مطلوبة";
                }
                return null;
              },
              onSaved: (value) {
                city = value;
              },
              onChanged: (value) {
                city = value;
              },
              icon: Icons.location_city,
            ),
            SizedBox(height: 10.h),
            Text(
              "الشارع",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ProfileTextFormField(
              hintText: "ادخل الشارع",
              initialValue: userInformation.address.street,
              validator: (value) {
                if (value!.isEmpty) {
                  return "الشارع مطلوب";
                }
                return null;
              },
              onSaved: (value) {
                street = value;
              },
              onChanged: (value) {
                street = value;
              },
              icon: Icons.streetview,
            ),
            SizedBox(height: 10.h),
            Text(
              "العنوان بالتفصيل",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ProfileTextFormField(
              hintText: "ادخل العنوان بالتفصيل",
              initialValue: userInformation.address.addressInDetails,
              validator: (value) {
                if (value!.isEmpty) {
                  return "العنوان بالتفصيل مطلوب";
                }
                return null;
              },
              onSaved: (value) {
                addressInDetails = value;
              },
              onChanged: (value) {
                addressInDetails = value;
              },
              icon: Icons.home,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileSuccess) {
                        context.pop();
                      } else if (state is ProfileError) {
                        showSnackBar(context: context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is ProfileLoading;
                      return CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<ProfileCubit>().updateUserInformation(
                              token: widget.token,
                              userUpdate: UserUpdate(
                                name: name!,
                                phone: phone!,
                                city: city!,
                                street: street!,
                                addressInDetails: addressInDetails!,
                              ),
                            );
                          }
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
