part of 'services_cubit.dart';

@immutable
sealed class ServicesState {}

final class ServicesInitial extends ServicesState {}
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
