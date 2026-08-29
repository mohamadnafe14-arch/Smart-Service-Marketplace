import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/custom_user_drawer.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final token = (context.read<AuthCubit>().state as AuthSuccess).user.token;
    return Scaffold(
      drawer: CustomUserDrawer(token: token),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Center(child: Text("User Home View")),
          Center(child: Text("User Home View")),
          Center(child: Text("User Home View")),
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
