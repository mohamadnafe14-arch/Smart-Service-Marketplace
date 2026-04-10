import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/core/functions/show_error_snack_bar.dart';
import 'package:smart_service_marketplace/core/utils/service_locator.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/get_provider_details_cubit/get_provider_details_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_details_body.dart';

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
