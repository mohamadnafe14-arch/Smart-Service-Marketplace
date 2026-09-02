import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_update.dart';
import 'package:smart_service_market_place/features/profile/model/repos/profile_repo.dart';

part 'profile_state.dart';
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  Future<void> fetchUserInformation({required String token}) async {
    emit(ProfileLoading());
    final result = await profileRepo.getUserInformation(token: token);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (userInformation) => emit(ProfileSuccess(userInformation)),
    );
  }

  Future<void> updateUserInformation({
    required String token,
    required UserUpdate userUpdate,
  }) async {
    emit(ProfileLoading());
    final result = await profileRepo.updateUserInformation(
      token: token,
      userUpdate: userUpdate,
    );
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (userInformation) => emit(ProfileSuccess(userInformation)),
    );
  }}
