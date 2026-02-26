import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}
