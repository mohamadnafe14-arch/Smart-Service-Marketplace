import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating});
  final Rating rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            if (index + 1 > rating.rate.ceil()) {
              return Icon(Icons.star_border, color: Colors.grey);
            }
            if (index + 1 > rating.rate.floor() &&
                rating.rate - rating.rate.floor() < 0.5) {
              return Icon(Icons.star_half_sharp, color: Colors.amber);
            }
            return Icon(Icons.star, color: Colors.amber);
          }),
        ),
        SizedBox(width: 10.w),
        Text("(${rating.rate.toString()})", style: TextStyle(fontSize: 16)),
        SizedBox(width: 10.w),
        Text("(${rating.count.toString()})", style: TextStyle(fontSize: 16)),
      ],
    );
  }
}