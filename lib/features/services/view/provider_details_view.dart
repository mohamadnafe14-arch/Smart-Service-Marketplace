import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';

class ProviderDetailsView extends StatelessWidget {
  const ProviderDetailsView({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final token =
        (BlocProvider.of<AuthCubit>(context).state as AuthSuccess).user.token;
    //ToDo: Add logic to fetch provider details using the id and token, and display them in the UI.
    return Scaffold();
  }
}
