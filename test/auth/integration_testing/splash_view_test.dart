import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';
import 'package:smart_service_market_place/features/auth/view/choose_role_view.dart';
import 'package:smart_service_market_place/features/auth/view/splash_view.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/home/provider_home_view.dart';
import 'package:smart_service_market_place/features/home/user_home_view.dart';
class MockAuthRepo extends Mock implements AuthRepo {}
void main() {
  late MockAuthRepo authRepo;
  late AuthCubit authCubit;
  final user = UserModel(
    id: 1,
    email: 'test@example.com',
    name: 'Test User',
    token: 'token123',
    role: 'user',
  );
  final provider = UserModel(
    id: 2,
    email: 'provider@example.com',
    name: 'Test Provider',
    token: 'token456',
    role: 'provider',
  );
  final failure = Failure(message: 'User Not Found');
  setUp(() {
    authRepo = MockAuthRepo();
    authCubit = AuthCubit(authRepo: authRepo);
    AppRouter.router.go(AppRouter.intialRoute);
  });
  tearDown(() async {
    await authCubit.close();
  });
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => BlocProvider.value(
        value: authCubit,
        child: MaterialApp.router(routerConfig: AppRouter.router),
      ),
    );
  }
  Future<void> pumpPastSplash(WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
  }
  group('SplashView authentication flow', () {
    testWidgets('shows choose-role when no authenticated user exists', (
      tester,
    ) async {
      when(
        () => authRepo.getCurrentUser(),
      ).thenAnswer((_) async => Left<Failure, UserModel>(failure));
      await mockNetworkImagesFor(() async {
        await pumpPastSplash(tester);
        expect(find.byType(SplashView), findsNothing);
        expect(find.byType(ChooseRoleView), findsOneWidget);
        verify(() => authRepo.getCurrentUser()).called(1);
      });
    });

    testWidgets('shows user home when an authenticated user is found', (
      tester,
    ) async {
      when(
        () => authRepo.getCurrentUser(),
      ).thenAnswer((_) async => Right<Failure, UserModel>(user));
      await mockNetworkImagesFor(() async {
        await pumpPastSplash(tester);
        expect(find.byType(UserHomeView), findsOneWidget);
        expect(find.byType(ProviderHomeView), findsNothing);
        verify(() => authRepo.getCurrentUser()).called(1);
      });
    });
    testWidgets('shows provider home for an authenticated provider', (
      tester,
    ) async {
      when(
        () => authRepo.getCurrentUser(),
      ).thenAnswer((_) async => Right<Failure, UserModel>(provider));
      await mockNetworkImagesFor(() async {
        await pumpPastSplash(tester);
        expect(find.byType(ProviderHomeView), findsOneWidget);
        expect(find.byType(UserHomeView), findsNothing);
        verify(() => authRepo.getCurrentUser()).called(1);
      });
    });
  });
}