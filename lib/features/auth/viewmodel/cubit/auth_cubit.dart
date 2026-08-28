
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';

part 'auth_state.dart';
@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepo.login(email: email, password: password);
    result.fold((l) => emit(AuthError(message: l.message)), (r) {
      emit(AuthSuccess(user: r));
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    final result = await authRepo.register(
      email: email,
      password: password,
      name: name,
    );
    result.fold((l) => emit(AuthError(message: l.message)), (r) {
      emit(AuthSuccess(user: r));
    });
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final user = await authRepo.getCurrentUser();
    user.fold((l) => emit(AuthInitial()), (r) {
      emit(AuthSuccess(user: r));
    });
  }

  Future<void> logout() async {
    final result = await authRepo.logout();
    result.fold((l) => emit(AuthError(message: l.message)), (r) {
      emit(AuthInitial());
    });
  }

  Future<void> setRole(String role) async {
    await authRepo.setRole(role);
  }

  Future<void> authWithGoogle() async {
    emit(AuthLoading());
    final result = await authRepo.authWithGoogle();
    result.fold((l) => emit(AuthError(message: l.message)), (r) {
      emit(AuthSuccess(user: r));
    });
  }}
