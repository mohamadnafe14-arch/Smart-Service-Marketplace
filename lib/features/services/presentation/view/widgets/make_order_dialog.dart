import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/widgets/custom_button.dart';
import 'package:smart_service_marketplace/features/services/data/models/make_order_param.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/get_provider_details_cubit/get_provider_details_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/custom_service_text_form_field.dart';

class MakeOrderDialog extends StatefulWidget {
  const MakeOrderDialog({super.key, required this.makeOrderParam});
  final MakeOrderParam makeOrderParam;
  @override
  State<MakeOrderDialog> createState() => _MakeOrderDialogState();
}

class _MakeOrderDialogState extends State<MakeOrderDialog> {
  late GlobalKey<FormState> _formKey;
  String? description, phone;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "رقم الهاتف",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomServiceTextFormField(
                  hintText: "ادخل رقم الهاتف",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يرجي ادخال رقم الهاتف";
                    }
                    if (!RegExp(r"^01[0125][0-9]{8}$").hasMatch(value)) {
                      return "يرجي ادخال رقم هاتف صحيح";
                    }
                    return null;
                  },
                  maxLines: 1,
                  onSaved: (value) {
                    phone = value;
                  },
                  onChanged: (value) {
                    phone = value;
                  },
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  initailValue:
                      widget.makeOrderParam.phone == "لم يتم تحديد الهاتف"
                      ? ""
                      : widget.makeOrderParam.phone,
                ),
                SizedBox(height: 10.h),
                Text(
                  "الوصف",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomServiceTextFormField(
                  hintText: "ادخل الوصف",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يرجي ادخال الوصف";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                  icon: Icons.description,
                  maxLines: null,
                  initailValue: null,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child:
                          BlocConsumer<
                            GetProviderDetailsCubit,
                            GetProviderDetailsState
                          >(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return CustomButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    //TODO: make order
                                    widget.makeOrderParam.pop.call();
                                  }
                                },
                                text: " تأكيد الطلب",
                                isLoading: false,
                              );
                            },
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
