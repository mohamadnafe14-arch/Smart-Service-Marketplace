import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/features/services/model/models/get_provider.dart';
import 'package:smart_service_market_place/features/services/model/repos/service_repo.dart';

part 'services_state.dart';
@injectable
class ServicesCubit extends Cubit<ServicesState> {
 final ServicesRepo servicesRepo;
  final String token;

  ServicesCubit(this.token, {required this.servicesRepo})
    : super(ServicesInitial());
  String selectedCategory = 'الكل';
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
      category: selectedCategory=='الكل'?'':selectedCategory,
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
  }}
