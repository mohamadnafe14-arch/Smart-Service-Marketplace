import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorBody extends StatelessWidget {
  final String message;
  const ErrorBody({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 16.sp),
      ),
    );
  }
}
