import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/core/utils/dependecy_injection.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/orders/model/models/order_cubit_params.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/order_body.dart';
import 'package:smart_service_market_place/features/orders/viewmodel/order_cubit/order_cubit.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/custom_provider_drawer.dart';

class ProviderHomeView extends StatefulWidget {
  const ProviderHomeView({super.key});

  @override
  State<ProviderHomeView> createState() => _ProviderHomeViewState();
}

class _ProviderHomeViewState extends State<ProviderHomeView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as AuthSuccess).user;
    final token = user.token;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: CustomProviderDrawer(token: token),
      body: IndexedStack(
        index: currentIndex,
        children: [
          BlocProvider(
            create: (context) => getIt<OrderCubit>(
              param1: OrderCubitParams(
                token: token,
                id: user.id.toString(),
                role: user.role,
              ),
            )..fetchOrders(),
            child: OrderBody(),
          ),
          Center(child: Text("Provider Home View")),
          Center(child: Text("Provider Home View")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
