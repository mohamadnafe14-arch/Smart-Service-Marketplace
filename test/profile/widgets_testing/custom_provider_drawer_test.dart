import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:smart_service_market_place/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/custom_provider_drawer.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit authCubit;
  const testToken = 'test-token';
  setUpAll(() {
    registerFallbackValue(AuthInitial());
  });
  setUp(() {
    authCubit = MockAuthCubit();
  });
  void setSurfaceSize(
    WidgetTester tester, {
    Size size = const Size(400, 1200),
  }) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  Widget makeTestableWidget({required Widget child}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return BlocProvider<AuthCubit>.value(
          value: authCubit,
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => Scaffold(
                  drawer: child,
                  body: Center(
                    child: Builder(
                      builder: (innerContext) => ElevatedButton(
                        onPressed: () => Scaffold.of(innerContext).openDrawer(),
                        child: const Text('Open Drawer'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  group('CustomProviderDrawer widget tests', () {
    testWidgets('renders drawer content when opened', (tester) async {
      setSurfaceSize(tester);
      whenListen(
        authCubit,
        Stream<AuthState>.fromIterable([]),
        initialState: AuthInitial(),
      );
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          makeTestableWidget(
            child: const CustomProviderDrawer(token: testToken),
          ),
        );
        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();
        expect(find.byType(Drawer), findsOneWidget);
        expect(find.text('تسجيل خروج'), findsOneWidget);
        expect(find.text('تعديل الملف الشخصي'), findsOneWidget);
        expect(find.byIcon(Icons.logout), findsOneWidget);
        expect(find.byIcon(Icons.edit), findsOneWidget);
      });
    });
    testWidgets('shows CircularProgressIndicator when AuthLoading', (
      tester,
    ) async {
      setSurfaceSize(tester);
      whenListen(
        authCubit,
        Stream<AuthState>.fromIterable([AuthLoading()]),
        initialState: AuthLoading(),
      );
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          makeTestableWidget(
            child: const CustomProviderDrawer(token: testToken),
          ),
        );
        await tester.tap(find.text('Open Drawer'));
        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('تسجيل خروج'), findsNothing);
      });
    });
    testWidgets('calls AuthCubit.logout() when logout tile tapped', (
      tester,
    ) async {
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
            child: const CustomProviderDrawer(token: testToken),
          ),
        );
        await tester.tap(find.text('Open Drawer'));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('تسجيل خروج'));
        await tester.tap(find.text('تسجيل خروج'));
        await tester.pump();
        verify(() => authCubit.logout()).called(1);
      });
    });
  });
}
