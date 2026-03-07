import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_service_marketplace/features/profile/data/model/provider_information.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
}
