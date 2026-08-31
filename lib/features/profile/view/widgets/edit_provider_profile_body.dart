import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/core/widgets/custom_button.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/provider_text_form_field.dart';

class EditProviderProfileBody extends StatefulWidget {
  const EditProviderProfileBody({super.key, required this.token});
  final String token;
  @override
  State<EditProviderProfileBody> createState() =>
      _EditProviderProfileBodyState();
}

class _EditProviderProfileBodyState extends State<EditProviderProfileBody> {
  final formKey = GlobalKey<FormState>();
  String? name, phone, city, street, addressInDetails, category, experience;
  @override
  Widget build(BuildContext context) {
    final userInformation = UserInformation(
      name: "name",
      id: 1,
      email: "email",
      phone: "phone",
      createdSince: "createdSince",
      address: Address(
        city: "city",
        street: "street",
        addressInDetails: "addressInDetails",
      ),
      statistics: Statistics(totalNumberOfOrders: 0, finishedOrders: 0),
      rating: Rating(rate: 0, count: 0),
      category: "category",
      experience: "experience",
    );
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
              initialValue: userInformation.phone ?? "لم يتم اضافة رقم الهاتف",
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
              initialValue:
                  userInformation.address.city ?? "لم يتم اضافة المدينة",
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
              initialValue:
                  userInformation.address.street ?? "لم يتم اضافة الشارع",
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
              initialValue:
                  userInformation.address.addressInDetails ??
                  "لم يتم اضافة العنوان بالتفصيل",
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
            SizedBox(height: 10.h),
            Text(
              "الفئة",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(value: "البناء", child: Text("البناء")),
                DropdownMenuItem(value: "الكهرباء", child: Text("الكهرباء")),
                DropdownMenuItem(value: "السباكة", child: Text("السباكة")),
                DropdownMenuItem(value: "البرمجة", child: Text("البرمجة")),
              ],
              onChanged: (value) {
                category = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return "يرجي اختيار الفئة";
                }
                return null;
              },
              onSaved: (value) {
                category = value;
              },
            ),
            SizedBox(height: 10.h),
            Text(
              "الخبرة",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ProfileTextFormField(
              hintText: "ادخل الخبرة",
              initialValue: userInformation.experience ?? "لم يتم اضافة الخبرة",
              validator: (value) {
                if (value!.isEmpty) {
                  return "الخبرة مطلوبة";
                }
                return null;
              },
              onSaved: (value) {
                experience = value;
              },
              onChanged: (value) {
                experience = value;
              },
              icon: Icons.work,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        //TODO: update provider information
                      }
                    },
                    text: "حفظ التغييرات",
                    isLoading: false,
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
