import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/services/model/repos/service_repo.dart';

part 'get_provider_details_state.dart';

@injectable
class GetProviderDetailsCubit extends Cubit<GetProviderDetailsState> {
  final ServicesRepo servicesRepo;
  GetProviderDetailsCubit({required this.servicesRepo})
    : super(GetProviderDetailsInitial());
  Future<void> getProviderDetails({
    required String id,
    required String token,
  }) async {
    emit(GetProviderDetailsLoading());
    final response = await servicesRepo.getProviderById(id: id, token: token);
    response.fold(
      (l) => emit(GetProviderDetailsError(message: l.message)),
      (r) => emit(GetProviderDetailsLoaded(userInformation: r)),
    );
  }

  Future<void> makeOrder({
    required String id,
    required String token,
    required String description,
    required String phone,
  }) async {
    await servicesRepo.makeOrder(
      id: id,
      token: token,
      description: description,
      phone: phone,
    );
  }
}
