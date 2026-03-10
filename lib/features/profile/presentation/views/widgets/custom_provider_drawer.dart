import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/core/widgets/error_body.dart';
import 'package:smart_service_marketplace/core/widgets/loading_body.dart';
import 'package:smart_service_marketplace/core/widgets/provider_information_widget.dart';
import 'package:smart_service_marketplace/features/profile/presentation/manager/cubit/profile_cubit.dart';

class CustomProviderDrawer extends StatefulWidget {
  const CustomProviderDrawer({super.key, required this.token});
  final String token;

  @override
  State<CustomProviderDrawer> createState() => _CustomProviderDrawerState();
}

class _CustomProviderDrawerState extends State<CustomProviderDrawer> {
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
            return ProviderInformationWidget(
              userInformation: state.userInformation,
              token: widget.token,
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
