import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';
import 'package:smart_service_marketplace/features/services/data/models/pagination_link.dart';

class ProvidersResponseModel {
  final List<GetProvider> providers;
  final List<PaginationLink> pagination;
  ProvidersResponseModel({required this.providers, required this.pagination});

  factory ProvidersResponseModel.fromJson(Map<String, dynamic> json) {
    return ProvidersResponseModel(
      providers: (json['data']['providers'] as List)
          .map((e) => GetProvider.fromJson(e))
          .toList(),
      pagination: (json['pagination'] as List)
          .map((e) => PaginationLink.fromJson(e))
          .toList(),
    );
  }
}
