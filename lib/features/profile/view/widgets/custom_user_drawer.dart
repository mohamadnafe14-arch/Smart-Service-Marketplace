import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/core/widgets/error_body.dart';
import 'package:smart_service_market_place/core/widgets/loading_body.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/user_information_body.dart';
import 'package:smart_service_market_place/features/profile/viewmodel/profile_cubit/profile_cubit.dart';
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
            return UserInformatioBody(
              userInformation: state.userInformation,
              token: widget.token,
              isShrinked: true,
            );
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