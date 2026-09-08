import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/core/widgets/empty_body.dart';
import 'package:smart_service_market_place/core/widgets/error_body.dart';
import 'package:smart_service_market_place/core/widgets/pagination_widget.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_shimmer_list.dart';
import 'package:smart_service_market_place/features/services/viewmodel/services_cubit/services_cubit.dart';

class ProviderList extends StatelessWidget {
  const ProviderList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoading) {
          return SliverFillRemaining(child: const ProviderShimmerList());
        }
        if (state is ServicesError) {
          return SliverFillRemaining(child: ErrorBody(message: state.message));
        }
        if (state is ServicesLoaded && state.providers.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                // Providers
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.providers.length,
                  itemBuilder: (context, index) =>
                      ProviderCard(getProvider: state.providers[index]),
                ),
                PaginationWidget(
                  links: state.pagination,
                  onPageSelected: (page) =>
                      context.read<ServicesCubit>().changePage(page),
                ),
              ],
            ),
          );
        } else if (state is ServicesLoaded && state.providers.isEmpty) {
          return SliverFillRemaining(
            child: const EmptyBody(message: "لا يوجد مزودين الان "),
          );
        }
        return SliverToBoxAdapter(child: const SizedBox());
      },
    );
  }
}
