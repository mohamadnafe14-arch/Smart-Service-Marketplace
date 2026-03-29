import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';

class ServicesCubit extends Cubit<void> {
  final ServicesRepo servicesRepo;

  ServicesCubit({required this.servicesRepo}) : super(null) {
    pagingController = PagingController<int, GetProvider>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        return state.nextIntPageKey;
      },
      fetchPage: (pageKey) async {
        if (_fetchFunction == null) throw Exception("Fetch not initialized");
        return await _fetchFunction!(pageKey);
      },
    );
  }

  late final PagingController<int, GetProvider> pagingController;

  Future<List<GetProvider>> Function(int pageKey)? _fetchFunction;

  void getAllServiceProviders({required String token}) {
    _fetchFunction = (pageKey) async {
      final response = await servicesRepo.getAllServiceProviders(
        token: token,
        page: pageKey,
      );

      return response.fold(
        (l) => throw Exception(l.message),
        (r) => r,
      );
    };

    pagingController.refresh();
  }

  void getProvidersByCategory({
    required String category,
    required String token,
  }) {
    _fetchFunction = (pageKey) async {
      final response = await servicesRepo.getProvidersByCategory(
        category: category,
        token: token,
        page: pageKey,
      );

      return response.fold(
        (l) => throw Exception(l.message),
        (r) => r,
      );
    };

    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}