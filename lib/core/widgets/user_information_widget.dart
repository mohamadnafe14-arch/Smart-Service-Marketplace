import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/statistic_widget.dart';
class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    super.key,
    required this.createdSince,
    required this.city,
    required this.street,
    required this.totalNumberOfOrders,
    required this.finishedOrders,
    required this.canceledOrders,
    required this.name,
    required this.email,
    required this.phone,
    required this.addressInDetails,
  });
  final String createdSince;
  final String city;
  final String street;
  final int totalNumberOfOrders;
  final int finishedOrders;
  final int canceledOrders;
  final String name;
  final String email;
  final String phone;
  final String addressInDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "الملف الشخصي",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Image.network(
          "https://cdn-icons-png.flaticon.com/512/149/149071.png",
          width: 100.w,
          height: 100.h,
        ),
        SizedBox(height: 10.h),
        Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5.h),
        Text(email, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 10.h),
        Text(phone, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 20.h),
        Text(createdSince, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(city, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(street, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(addressInDetails, style: TextStyle(fontSize: 16)),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StatisticWidget(
                title: "عملية جارية",
                value: (totalNumberOfOrders - finishedOrders).toString(),
              ),
            ),
            Expanded(
              child: StatisticWidget(
                title: "العمليات الناجحة",
                value: finishedOrders.toString(),
              ),
            ),
            Expanded(
              child: StatisticWidget(
                title: "إجمالي العمليات",
                value: totalNumberOfOrders.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
