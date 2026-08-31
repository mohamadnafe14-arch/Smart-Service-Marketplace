import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
import 'package:smart_service_market_place/features/profile/model/models/user_information.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/provider_information_body.dart';
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
void main() {
  late MockAuthCubit authCubit;
  late UserInformation userInformation;
  const testToken = 'test-token';

  setUpAll(() {
    registerFallbackValue(AuthInitial());
  });

  setUp(() {
    authCubit = MockAuthCubit();
    userInformation = UserInformation(
      name: 'Jane Provider',
      email: 'jane@example.com',
      phone: '0123456789',
      id: 1,
      createdSince: '2022-01-01',
      address: Address(
        city: 'Cairo',
        street: 'Tahrir St',
        addressInDetails: 'Near the square',
      ),
      statistics: Statistics(totalNumberOfOrders: 0, finishedOrders: 0),
      rating: Rating(rate: 0, count: 0),
    );
  });
  void setSurfaceSize(WidgetTester tester, {Size size = const Size(400, 1200)}) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }
  Widget makeTestableWidget({required Widget child, GoRouter? router}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return BlocProvider<AuthCubit>.value(
          value: authCubit,
          child: router != null
              ? MaterialApp.router(routerConfig: router)
              : MaterialApp(home: Scaffold(body: child)),
        );
      },
    );
  }
  group('ProviderInformationBody widget tests', () {
    testWidgets(
      'renders ProviderInformationWidget, logout tile and edit profile tile',
      (tester) async {
        setSurfaceSize(tester);
        whenListen(
          authCubit,
          Stream<AuthState>.fromIterable([]),
          initialState: AuthInitial(),
        );
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            makeTestableWidget(
              child: ProviderInformationBody(
                userInformation: userInformation,
                token: testToken,
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text('تسجيل خروج'), findsOneWidget);
          expect(find.text('تعديل الملف الشخصي'), findsOneWidget);
          expect(find.byIcon(Icons.logout), findsOneWidget);
          expect(find.byIcon(Icons.edit), findsOneWidget);
          expect(find.byType(Card), findsNWidgets(2));
        });
      },
    );
    testWidgets(
      'shows CircularProgressIndicator when AuthLoading state is emitted',
      (tester) async {
        setSurfaceSize(tester);
        whenListen(
          authCubit,
          Stream<AuthState>.fromIterable([AuthLoading()]),
          initialState: AuthLoading(),
        );
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            makeTestableWidget(
              child: ProviderInformationBody(
                userInformation: userInformation,
                token: testToken,
              ),
            ),
          );
          await tester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(find.text('تسجيل خروج'), findsNothing);
        });
      },
    );
    testWidgets(
      'calls AuthCubit.logout() when logout tile is tapped',
      (tester) async {
        setSurfaceSize(tester);
        when(() => authCubit.logout()).thenAnswer((_) async {});
        whenListen(
          authCubit,
          Stream<AuthState>.fromIterable([]),
          initialState: AuthInitial(),
        );
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            makeTestableWidget(
              child: ProviderInformationBody(
                userInformation: userInformation,
                token: testToken,
              ),
            ),
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(find.text('تسجيل خروج'));
          await tester.tap(find.text('تسجيل خروج'));
          await tester.pump();
          verify(() => authCubit.logout()).called(1);
        });
      },
    );
    testWidgets(
      'navigates to chooseRoleRoute when AuthInitial state is emitted after loading',
      (tester) async {
        setSurfaceSize(tester);
        final router = GoRouter(
          initialLocation: '/provider-profile',
          routes: [
            GoRoute(
              path: '/provider-profile',
              builder: (context, state) => Scaffold(
                body: ProviderInformationBody(
                  userInformation: userInformation,
                  token: testToken,
                ),
              ),
            ),
            GoRoute(
              path: AppRouter.chooseRoleRoute,
              builder: (context, state) =>
                  const Scaffold(body: Text('Choose Role Screen')),
            ),
          ],
        );
        whenListen(
          authCubit,
          Stream<AuthState>.fromIterable([AuthLoading(), AuthInitial()]),
          initialState: AuthLoading(),
        );
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            makeTestableWidget(child: const SizedBox(), router: router),
          );
          await tester.pumpAndSettle();
          expect(find.text('Choose Role Screen'), findsOneWidget);
        });
      },
    );
    testWidgets(
      'navigates to editProviderProfileViewRoute with token when edit tile is tapped',
      (tester) async {
        setSurfaceSize(tester);
        final router = GoRouter(
          initialLocation: '/provider-profile',
          routes: [
            GoRoute(
              path: '/provider-profile',
              builder: (context, state) => Scaffold(
                body: ProviderInformationBody(
                  userInformation: userInformation,
                  token: testToken,
                ),
              ),
            ),
            GoRoute(
              path: AppRouter.editProviderProfileViewRoute,
              builder: (context, state) {
                final extra = state.extra as String?;
                return Scaffold(body: Text('Edit Provider Profile: $extra'));
              },
            ),
          ],
        );
        whenListen(
          authCubit,
          Stream<AuthState>.fromIterable([]),
          initialState: AuthInitial(),
        );
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            makeTestableWidget(child: const SizedBox(), router: router),
          );
          await tester.pumpAndSettle();
          await tester.ensureVisible(find.text('تعديل الملف الشخصي'));
          await tester.pumpAndSettle();
          await tester.tap(find.text('تعديل الملف الشخصي'));
          await tester.pumpAndSettle();
          expect(find.text('Edit Provider Profile: $testToken'), findsOneWidget);
        });
      },
    );
  });
}