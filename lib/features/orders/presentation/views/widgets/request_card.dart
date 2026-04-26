import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/functions/get_color_by_status.dart';
import 'package:smart_service_marketplace/features/orders/data/model/order_model.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/custom_action_button.dart';

class RequestCard extends StatelessWidget {
  final OrderModel order;

  const RequestCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = getColorByStatus(order.status);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.userName,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(order.phoneUser, style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 10.h),
          Text(order.description),
          SizedBox(height: 10.h),
          Text(
            "اخر تحديث: ${order.updatedAt}",
            style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
          ),
          SizedBox(height: 15.h),
          order.status == "pending"
              ? Row(
                  children: [
                    Expanded(
                      child: CustomActionButton(
                        text: "Accept",
                        color: Colors.green,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomActionButton(
                        text: "Reject",
                        color: Colors.red,
                        onTap: () {},
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
