import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/core/functions/show_success_snack_bar.dart';
import 'package:smart_service_market_place/core/widgets/custom_button.dart';
import 'package:smart_service_market_place/features/services/model/models/make_order_param.dart';
import 'package:smart_service_market_place/features/services/view/widgets/custom_service_text_form_field.dart';

class MakeOrderDialog extends StatefulWidget {
  const MakeOrderDialog({
    super.key,
    required this.makeOrderParam,
    required this.pop,
  });
  final MakeOrderParam makeOrderParam;
  final VoidCallback pop;
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: SingleChildScrollView(
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
                        child: CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              //TODO: implement the logic to make the order using the provided parameters
                              widget.makeOrderParam.pop.call();
                              showSuccessToast(context, "تم عمل الطلب بنجاح");
                            }
                          },
                          text: " تأكيد الطلب",
                          isLoading: false,
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
