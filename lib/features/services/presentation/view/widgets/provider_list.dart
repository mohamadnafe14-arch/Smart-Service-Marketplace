import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_service_marketplace/core/functions/show_error_snack_bar.dart';
import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/service_states.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/services_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/provider_card.dart';

class ProviderList extends StatelessWidget {
  const ProviderList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        if (state is ServicesError) {
          showErrorToast(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return PagingListener(
          controller: context.read<ServicesCubit>().pagingController,
          builder: (context, state, fetchNextPage) {
            return PagedListView<int, GetProvider>.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<GetProvider>(
                itemBuilder: (context, provider, index) {
                  return ProviderCard(getProvider: provider);
                },
                firstPageProgressIndicatorBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                firstPageErrorIndicatorBuilder: (_) =>
                    const Center(child: Text('حدث خطأ')),
                noItemsFoundIndicatorBuilder: (_) => Center(
                  child: Text(
                    ' لا يوجد مقدمون خدمات الان',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
            );
          },
        );
      },
    );
  }
}
