import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
class MockAuthRepo extends Mock implements AuthRepo {}
void main() {
  late MockAuthRepo mockAuthRepo;
  late AuthCubit authCubit;
  final tUser = UserModel(
    id: 1,
    email: 'test@example.com',
    name: 'Test User',
    token: 'token123',
    role: 'user',
  );
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tName = 'Test User';
  final tFailure = Failure(message: 'Something went wrong');
  setUp(() {
    mockAuthRepo = MockAuthRepo();
    authCubit = AuthCubit(authRepo: mockAuthRepo);
  });
  tearDown(() {
    authCubit.close();
  });
  test('initial state is AuthInitial', () {
    expect(authCubit.state, isA<AuthInitial>());
  });
  group('login', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login succeeds',
      build: () {
        when(
          () => mockAuthRepo.login(email: tEmail, password: tPassword),
        ).thenAnswer(
          (_) async => Future.value(Right<Failure, UserModel>(tUser)),
        );
        return authCubit;
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>().having((s) => s.user, 'user', tUser),
      ],
      verify: (_) {
        verify(
          () => mockAuthRepo.login(email: tEmail, password: tPassword),
        ).called(1);
      },
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] when login fails',
      build: () {
        when(
          () => mockAuthRepo.login(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => Left<Failure, UserModel>(tFailure));
        return authCubit;
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having((s) => s.message, 'message', tFailure.message),
      ],
    );
  });
  group('register', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when register succeeds',
      build: () {
        when(
          () => mockAuthRepo.register(
            email: tEmail,
            password: tPassword,
            name: tName,
          ),
        ).thenAnswer((_) async => Right<Failure, UserModel>(tUser));
        return authCubit;
      },
      act: (cubit) =>
          cubit.register(email: tEmail, password: tPassword, name: tName),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>().having((s) => s.user, 'user', tUser),
      ],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] when register fails',
      build: () {
        when(
          () => mockAuthRepo.register(
            email: tEmail,
            password: tPassword,
            name: tName,
          ),
        ).thenAnswer((_) async => Left<Failure, UserModel>(tFailure));
        return authCubit;
      },
      act: (cubit) =>
          cubit.register(email: tEmail, password: tPassword, name: tName),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having((s) => s.message, 'message', tFailure.message),
      ],
    );
  });
  group('getCurrentUser', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when a user is found',
      build: () {
        when(
          () => mockAuthRepo.getCurrentUser(),
        ).thenAnswer((_) async => Right<Failure, UserModel>(tUser));
        return authCubit;
      },
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>().having((s) => s.user, 'user', tUser),
      ],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthInitial] when no user is found',
      build: () {
        when(
          () => mockAuthRepo.getCurrentUser(),
        ).thenAnswer((_) async => Left<Failure, UserModel>(tFailure));
        return authCubit;
      },
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [isA<AuthLoading>(), isA<AuthInitial>()],
    );
  });
  group('logout', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthInitial] when logout succeeds',
      build: () {
        when(
          () => mockAuthRepo.logout(),
        ).thenAnswer((_) async => Right<Failure, void>(null));
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [isA<AuthInitial>()],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthError] when logout fails',
      build: () {
        when(
          () => mockAuthRepo.logout(),
        ).thenAnswer((_) async => Left<Failure, void>(tFailure));
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        isA<AuthError>().having((s) => s.message, 'message', tFailure.message),
      ],
    );
  });
  group('setRole', () {
    blocTest<AuthCubit, AuthState>(
      'does not emit a new state and calls repo.setRole',
      build: () {
        when(() => mockAuthRepo.setRole('provider')).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.setRole('provider'),
      expect: () => [],
      verify: (_) {
        verify(() => mockAuthRepo.setRole('provider')).called(1);
      },
    );
  });
  group('authWithGoogle', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthSuccess] when google auth succeeds',
      build: () {
        when(
          () => mockAuthRepo.authWithGoogle(),
        ).thenAnswer((_) async => Right<Failure, UserModel>(tUser));
        return authCubit;
      },
      act: (cubit) => cubit.authWithGoogle(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>().having((s) => s.user, 'user', tUser),
      ],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthError] when google auth fails',
      build: () {
        when(
          () => mockAuthRepo.authWithGoogle(),
        ).thenAnswer((_) async => Left<Failure, UserModel>(tFailure));
        return authCubit;
      },
      act: (cubit) => cubit.authWithGoogle(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthError>().having((s) => s.message, 'message', tFailure.message),
      ],
    );
  });
}