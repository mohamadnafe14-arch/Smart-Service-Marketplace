import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/service_states.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepo servicesRepo;
  final String token;

  ServicesCubit(this.token, {required this.servicesRepo})
    : super(ServicesInitial());
  String selectedCategory = '';
  int currentPage = 1;
  void changeCategory(String category) {
    selectedCategory = category;
    currentPage = 1;
    fetchProviders();
  }

  void changePage(int page) {
    currentPage = page;
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    emit(ServicesLoading());
    final result = await servicesRepo.getProvidersByCategory(
      category: selectedCategory,
      page: currentPage,
      token: token,
    );

    result.fold(
      (failure) => emit(ServicesError(failure.message)),
      (response) => emit(
        ServicesLoaded(
          providers: response.providers,
          pagination: response.pagination,
          selectedCategory: selectedCategory,
          currentPage: currentPage,
        ),
      ),
    );
  }
}
