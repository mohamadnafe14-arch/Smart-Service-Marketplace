import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RequestCardShimmer extends StatelessWidget {
  const RequestCardShimmer({super.key});

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.w,
          horizontal: 12.w,
        ),
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User name + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(
                  width: 120.w,
                  height: 20.h,
                ),
                _buildShimmerBox(
                  width: 75.w,
                  height: 30.h,
                  radius: 20,
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // Phone
            _buildShimmerBox(
              width: 150.w,
              height: 16.h,
            ),

            SizedBox(height: 10.h),

            // Description
            _buildShimmerBox(
              width: double.infinity,
              height: 18.h,
            ),

            SizedBox(height: 6.h),

            _buildShimmerBox(
              width: 220.w,
              height: 18.h,
            ),

            SizedBox(height: 10.h),

            // Last update
            _buildShimmerBox(
              width: 140.w,
              height: 14.h,
            ),

            SizedBox(height: 15.h),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _buildShimmerBox(
                    width: double.infinity,
                    height: 45.h,
                    radius: 8,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildShimmerBox(
                    width: double.infinity,
                    height: 45.h,
                    radius: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}