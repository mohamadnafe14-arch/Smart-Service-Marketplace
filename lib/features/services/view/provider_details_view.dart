import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/core/functions/show_error_snack_bar.dart';
import 'package:smart_service_market_place/core/utils/dependecy_injection.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/services/model/repos/service_repo.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_details_body.dart';
import 'package:smart_service_market_place/features/services/viewmodel/get_provider_details_cubit/get_provider_details_cubit.dart';

class ProviderDetailsView extends StatelessWidget {
  const ProviderDetailsView({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final token =
        (BlocProvider.of<AuthCubit>(context).state as AuthSuccess).user.token;
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            GetProviderDetailsCubit(servicesRepo: getIt<ServicesRepo>())
              ..getProviderDetails(id: id.toString(), token: token),
        child: Scaffold(
          body: BlocConsumer<GetProviderDetailsCubit, GetProviderDetailsState>(
            listener: (context, state) {
              if (state is GetProviderDetailsError) {
                showErrorToast(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is GetProviderDetailsLoaded) {
                return ProviderDetailsBody(
                  providerInformation: state.userInformation,
                );
              } else if (state is GetProviderDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetProviderDetailsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
