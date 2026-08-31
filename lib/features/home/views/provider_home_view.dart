import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
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
    final token = (context.read<AuthCubit>().state as AuthSuccess).user.token;
    return Scaffold(
      drawer: CustomProviderDrawer(token: token),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Center(child: Text("Provider Home View")),
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
