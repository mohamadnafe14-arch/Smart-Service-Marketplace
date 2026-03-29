import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/services/data/repos/services_repo.dart';
part 'get_provider_details_state.dart';
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
}
