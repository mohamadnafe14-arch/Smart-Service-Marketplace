import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/core/utils/service_locator.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/custom_user_drawer.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/services_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/services_body.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomUserDrawer(token: user.token),
        body: BlocProvider(
          create: (context) =>
              ServicesCubit(servicesRepo: getIt<ServicesRepo>())
                ..getAllServiceProviders(token: user.token),
          child: ServicesBody(),
        ),
      ),
    );
  }
}
