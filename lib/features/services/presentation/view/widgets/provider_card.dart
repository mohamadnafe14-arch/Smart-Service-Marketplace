import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key, required this.getProvider});

  final GetProvider getProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouter.providerDetailsRoute, extra: getProvider.id!);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              getProvider.category == "لم يتم تحديد الفئة"
                  ? CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 30.sp,
                        color: Colors.white,
                      ),
                    )
                  : Image.asset(
                      "assets/images/${getProvider.category}.jpg",
                      width: 60.w,
                      height: 60.h,
                    ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getProvider.name ?? "لم يتم تحديد الاسم",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      getProvider.category ?? "لم يتم تحديد الفئة",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4.w),
                        Text(
                          getProvider.rating!.toString(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
