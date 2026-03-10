import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_information.dart';
import 'package:smart_service_marketplace/features/profile/data/model/user_update.dart';
import 'package:smart_service_marketplace/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

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
  }
}
