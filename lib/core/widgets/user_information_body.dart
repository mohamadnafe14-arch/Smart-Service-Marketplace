import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/widgets/user_information_widget.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';

class UserInformatioBody extends StatelessWidget {
  final UserInformation userInformation;
  const UserInformatioBody({
    super.key,
    required this.userInformation,
    required this.token,
  });
  final String token;
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
          UserInformationWidget(userInformation: userInformation),
          SizedBox(height: 20.h),
          Card(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial) {
                  GoRouter.of(context).go(AppRouter.chooseRoleRoute);
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
                GoRouter.of(
                  context,
                ).push(AppRouter.editUserProfileRoute, extra: token);
              },
            ),
          ),
        ],
      ),
    );
  }
}
