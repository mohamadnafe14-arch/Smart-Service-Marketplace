import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/statistic_widget.dart';

class ProviderInformationWidget extends StatelessWidget {
  const ProviderInformationWidget({
    super.key,
    required this.userInformation,
  });

  final UserInformation userInformation;

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
        Text(
          userInformation.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.h),
        Text(
          userInformation.email,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 10.h),
        Text(
          userInformation.phone,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 20.h),
        Text(userInformation.createdSince, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(userInformation.address.city, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(userInformation.address.street, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(
          userInformation.address.addressInDetails,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatisticWidget(
              title: "عملية جارية",
              value:
                  (userInformation.statistics.totalNumberOfOrders -
                          userInformation.statistics.finishedOrders)
                      .toString(),
            ),
            StatisticWidget(
              title: "العمليات الناجحة",
              value: userInformation.statistics.finishedOrders.toString(),
            ),
            StatisticWidget(
              title: "إجمالي العمليات",
              value: userInformation.statistics.totalNumberOfOrders
                  .toString(),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                if (index + 1 > userInformation.rating.rate.ceil()) {
                  return Icon(Icons.star_border, color: Colors.grey);
                }
                if (index + 1 > userInformation.rating.rate.floor() &&
                    userInformation.rating.rate -
                            userInformation.rating.rate.floor() <
                        0.5) {
                  return Icon(Icons.star_half_sharp, color: Colors.amber);
                }
                return Icon(Icons.star, color: Colors.amber);
              }),
            ),
            SizedBox(width: 10.w),
            Text(
              "(${userInformation.rating.rate.toString()})",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 10.w),
            Text(
              "(${userInformation.rating.count.toString()})",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(userInformation.category, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10.h),
        Text(userInformation.experience, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}