import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/service_states.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/services_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/pagination_widget.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_card.dart';
class ProviderList extends StatelessWidget {
  const ProviderList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ServicesError) {
          return Center(child: Text(state.message));
        }
        if (state is ServicesLoaded) {
          return Column(
            children: [
              // Providers
              Expanded(
                child: ListView.builder(
                  itemCount: state.providers.length,
                  itemBuilder: (context, index) =>
                      ProviderCard(getProvider: state.providers[index]),
                ),
              ),
              PaginationWidget(
                links: state.pagination,
                onPageSelected: (page) =>
                    context.read<ServicesCubit>().changePage(page),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}