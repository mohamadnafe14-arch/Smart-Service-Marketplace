import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/auth/presentation/viewmodel/auth_cubit/auth_cubit.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/request_card.dart';
import 'package:smart_service_marketplace/features/orders/presentation/views/widgets/user_card.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/service_states.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/services_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/pagination_widget.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoading) {
          return SliverFillRemaining(
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ServicesError) {
          return SliverFillRemaining(child: Center(child: Text(state.message)));
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
                  itemBuilder: (context, index) {
                    final String role =
                        (BlocProvider.of<AuthCubit>(context).state
                                as AuthSuccess)
                            .user
                            .role;
                    return role == "user"
                        ? UserCard(
                            status: "",
                            userName: "",
                            phone: "",
                            description: "",
                            updatedAt: "",
                          )
                        : RequestCard(
                            status: "",
                            userName: "",
                            phone: "",
                            description: "",
                            updatedAt: "",
                          );
                  },
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
            child: const Center(
              child: Text(
                "لا يوجد خدمات",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
