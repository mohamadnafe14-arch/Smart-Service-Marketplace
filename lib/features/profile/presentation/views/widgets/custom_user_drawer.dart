import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_service_marketplace/core/utils/app_router.dart';
import 'package:smart_service_marketplace/core/widgets/error_body.dart';
import 'package:smart_service_marketplace/core/widgets/loading_body.dart';
import 'package:smart_service_marketplace/core/widgets/user_information_widget.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/profile/data/model/provider_information.dart';
import 'package:smart_service_marketplace/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/statistic_widget.dart';

class CustomUserDrawer extends StatefulWidget {
  const CustomUserDrawer({super.key, required this.token});
  final String token;
  @override
  State<CustomUserDrawer> createState() => _CustomUserDrawerState();
}

class _CustomUserDrawerState extends State<CustomUserDrawer> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(
      context,
    ).fetchUserInformation(token: widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            return UserInformatioWidget(userInformation: state.userInformation);
          } else if (state is ProfileLoading) {
            return LoadingBody();
          } else if (state is ProfileError) {
            return ErrorBody(message: state.message);
          }
          return SizedBox();
        },
      ),
    );
  }
}
