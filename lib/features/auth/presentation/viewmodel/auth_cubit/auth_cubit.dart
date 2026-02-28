import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_marketplace/features/auth/data/model/user.dart';
import 'package:smart_service_marketplace/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

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

  Future<void> getCurrentUser(BuildContext context) async {
    final user = await authRepo.getCurrentUser();
    emit(AuthLoading());
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
}
