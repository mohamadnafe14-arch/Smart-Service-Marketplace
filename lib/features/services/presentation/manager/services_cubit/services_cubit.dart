import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_service_marketplace/features/services/data/models/get_provider.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/service_states.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepo servicesRepo;

  ServicesCubit({required this.servicesRepo}) : super(ServicesInitial()) {
    pagingController = PagingController<int, GetProvider>(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) return null;
        return (state.keys?.last ?? 0) + 1;
      },
      fetchPage: (pageKey) async {
        try {
          if (_fetchFunction == null) throw Exception("Fetch not initialized");
          final result = await _fetchFunction!(pageKey);
          print('✅ Page $pageKey loaded: ${result.length} items');
          return result;
        } catch (e, stackTrace) {
          print('❌ Error on page $pageKey: $e');
          print(stackTrace);
          rethrow;
        }
      },
    );
  }
  late final PagingController<int, GetProvider> pagingController;
  Future<List<GetProvider>> Function(int pageKey)? _fetchFunction;
  void getAllServiceProviders({required String token}) {
    emit(ServicesLoading());
    _fetchFunction = (pageKey) async {
      final response = await servicesRepo.getAllServiceProviders(
        token: token,
        page: pageKey,
      );
      return response.fold((l) => throw Exception(l.message), (r) {
        emit(ServicesLoaded());
        return r;
      });
    };
    pagingController.refresh();
  }

  void getProvidersByCategory({
    required String category,
    required String token,
  }) {
    emit(ServicesLoading());
    _fetchFunction = (pageKey) async {
      final response = await servicesRepo.getProvidersByCategory(
        category: category,
        token: token,
        page: pageKey,
      );
      return response.fold((l) => throw Exception(l.message), (r) {
        emit(ServicesLoaded());
        return r;
      });
    };
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
