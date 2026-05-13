import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28.r,
          child: Icon(Icons.person, size: 30.sp),
        ),
        title: const Text(
          "Ahmed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          "فينك يا صاحبي؟",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          "2:30 PM",
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ),
    );
  }
}
