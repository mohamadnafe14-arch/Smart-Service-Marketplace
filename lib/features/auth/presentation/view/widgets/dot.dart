import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dot extends StatelessWidget {
  const Dot({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      width: isActive ? 14.w : 10.w,
      height: isActive ? 14.w : 10.w,
      decoration: BoxDecoration(
        color: isActive
            ? Colors.lightBlueAccent
            : Colors.white24,
        shape: BoxShape.circle,
      ),
    );
  }
}