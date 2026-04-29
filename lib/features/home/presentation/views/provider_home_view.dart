import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:smart_service_marketplace/core/utils/service_locator.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/orders/data/repo/order_repo.dart';
import 'package:smart_service_marketplace/features/orders/presentation/manager/order_cubit/order_cubit.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/order_body.dart';
import 'package:smart_service_marketplace/features/profile/presentation/views/widgets/custom_provider_drawer.dart';

class ProviderHomeView extends StatelessWidget {
  const ProviderHomeView({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(
        token: user.token,
        orderRepo: getIt<OrderRepo>(),
        pusher: getIt<PusherChannelsFlutter>(),
        role: user.role,
        id: user.id.toString(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomProviderDrawer(token: user.token),
        body: const OrderBody(), 
      ),
    );
  }
}
