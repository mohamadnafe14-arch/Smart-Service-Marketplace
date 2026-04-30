import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_marketplace/core/utils/service_locator.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/orders/data/repo/order_repo.dart';
import 'package:smart_service_marketplace/features/orders/presentation/manager/order_cubit/order_cubit.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/order_body.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/custom_user_drawer.dart';


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
          create: (context) => OrderCubit(
            token: user.token,
            orderRepo: getIt<OrderRepo>(),
            pusher: getIt<PusherChannelsFlutter>(),
            role: user.role,
            id: user.id.toString(),
          )..init(),
          child: const OrderBody(),
        ),
      ),
    );
  }
}
