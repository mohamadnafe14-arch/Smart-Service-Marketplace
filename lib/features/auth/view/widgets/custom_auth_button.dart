import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.grey : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.black : Colors.blue,
        ),
      ),
    );
  }
}
