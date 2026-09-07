import 'package:flutter/material.dart';
import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/core/widgets/pagination_widget.dart';
import 'package:smart_service_market_place/features/services/model/models/get_provider.dart';
import 'package:smart_service_market_place/features/services/view/widgets/provider_card.dart';

class ProviderList extends StatelessWidget {
  const ProviderList({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      key: Key('providerListColumn'),
      children: [
        Expanded(
          child: ListView.builder(
            key: Key('providerListView'),
            itemBuilder: (context, index) {
              return ProviderCard(
                getProvider: GetProvider(
                  id: 1,
                  name: "Provider Name",
                  role: "Provider Role",
                  phone: "Provider Phone",
                  category: "لم يتم تحديد الفئة",
                  rating: 4.5,
                ),
              );
            },
          ),
        ),
        PaginationWidget(
          links: [
            PaginationLink(label: '1', url: '/page/1', active: true),
            PaginationLink(label: '2', url: '/page/2', active: false),
            PaginationLink(label: '3', url: '/page/3', active: false),
          ],
          onPageSelected: (int pageNum) {
            // Handle page selection
          },
        ),
      ],
    );
  }
}
