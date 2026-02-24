import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpCodeBody extends StatefulWidget {
  const OtpCodeBody({super.key});

  @override
  State<OtpCodeBody> createState() => _OtpCodeBodyState();
}

class _OtpCodeBodyState extends State<OtpCodeBody> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  bool hasError = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }

    if (hasError) {
      setState(() {
        hasError = false;
      });
    }
  }

  String getCode() {
    return controllers.map((e) => e.text).join();
  }

  bool validateCode() {
    String code = getCode();
    return RegExp(r'^[0-9]{6}$').hasMatch(code);
  }

  OutlineInputBorder borderStyle(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "أدخل كود التحقق",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 45.w,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: borderStyle(
                    hasError ? Colors.red : Colors.grey,
                  ),
                  focusedBorder: borderStyle(
                    hasError ? Colors.red : Colors.blue,
                  ),
                ),
                onChanged: (value) => onChanged(value, index),
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
        ElevatedButton(
          onPressed: () {
            if (!validateCode()) {
              setState(() {
                hasError = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("يرجى إدخال كود مكون من 6 أرقام صحيحة"),
                ),
              );
              return;
            }
         //   String code = getCode();
          },
          child: const Text("تأكيد"),
        ),
      ],
    );
  }
}
