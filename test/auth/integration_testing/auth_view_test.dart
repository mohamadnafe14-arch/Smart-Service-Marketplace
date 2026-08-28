import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/features/auth/model/models/user_model.dart';
import 'package:smart_service_market_place/features/auth/model/repos/auth_repo.dart';
import 'package:smart_service_market_place/features/auth/view/auth_view.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/auth_body.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/sign_in_body.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/sign_up_body.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/home/views/user_home_view.dart';
class MockAuthRepo extends Mock implements AuthRepo {}
void main() {
  late MockAuthRepo authRepo;
  late AuthCubit authCubit;
  final user = UserModel(
    id: 1,
    email: 'user@stm.com',
    name: 'Test User',
    token: 'token123',
    role: 'user',
  );
  setUp(() {
    authRepo = MockAuthRepo();
    authCubit = AuthCubit(authRepo: authRepo);
    AppRouter.router.go(AppRouter.authRoute);
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
  Future<void> pumpAuthView(WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(1000, 1400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
  }
  group('AuthView integration flow', () {
    testWidgets('opens the auth route with sign-in selected', (tester) async {
      await pumpAuthView(tester);
      expect(find.byType(AuthView), findsOneWidget);
      expect(find.byType(AuthBody), findsOneWidget);
      expect(find.byType(SignInBody), findsOneWidget);
      expect(find.byType(SignUpBody), findsNothing);
      expect(find.text('تسجيل الدخول'), findsOneWidget);
      expect(find.text('انشاء حساب'), findsOneWidget);
    });
    testWidgets('switches between sign-in and sign-up forms', (tester) async {
      await pumpAuthView(tester);
      await tester.tap(find.text('انشاء حساب'));
      await tester.pumpAndSettle();
      expect(find.byType(SignUpBody), findsOneWidget);
      expect(find.byType(SignInBody), findsNothing);
      expect(find.byType(TextFormField), findsNWidgets(3));
      await tester.tap(find.text('تسجيل الدخول'));
      await tester.pumpAndSettle();
      expect(find.byType(SignInBody), findsOneWidget);
      expect(find.byType(SignUpBody), findsNothing);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });
    testWidgets('logs in through the form and navigates to user home', (
      tester,
    ) async {
      when(
        () => authRepo.login(email: 'user@stm.com', password: 'password123'),
      ).thenAnswer((_) async => Right<Failure, UserModel>(user));
      await pumpAuthView(tester);
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'user@stm.com');
      await tester.enterText(fields.at(1), 'password123');
      await tester.tap(find.text('ابدأ الان'));
      await tester.pumpAndSettle();
      expect(find.byType(UserHomeView), findsOneWidget);
      expect(find.byType(AuthView), findsNothing);
      verify(
        () => authRepo.login(email: 'user@stm.com', password: 'password123'),
      ).called(1);
    });
  });
}