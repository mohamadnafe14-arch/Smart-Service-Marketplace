import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';
import 'package:smart_service_marketplace/features/services/data/models/pagination_link.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<GetProvider> providers;
  final List<PaginationLink> pagination;
  final String selectedCategory;
  final int currentPage;

  ServicesLoaded({
    required this.providers,
    required this.pagination,
    required this.selectedCategory,
    required this.currentPage,
  });
}

class ServicesError extends ServicesState {
  final String message;
  ServicesError(this.message);
}
