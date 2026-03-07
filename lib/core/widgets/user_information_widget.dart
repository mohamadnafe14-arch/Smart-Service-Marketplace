import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/statistic_widget.dart';

class UserInformatioWidget extends StatelessWidget {
  final UserInformation userInformation;
  const UserInformatioWidget({super.key, required this.userInformation});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      child: Column(
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
                value: userInformation.statistics.totalNumberOfOrders.toString(),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Card(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial) {
                  GoRouter.of(context).go(AppRouter.authRoute);
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                return ListTile(
                  title: isLoading
                      ? CircularProgressIndicator()
                      : Text("تسجيل خروج"),
                  trailing: Icon(Icons.logout),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).logout();
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          Card(
            child: ListTile(
              title: Text("تعديل الملف الشخصي"),
              trailing: Icon(Icons.edit),
              onTap: () {
                GoRouter.of(context).push(AppRouter.editUserProfileRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
