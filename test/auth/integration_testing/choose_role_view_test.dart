import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/core/utils/app_router.dart';
import 'package:smart_service_market_place/features/auth/view/choose_role_view.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/role_card.dart';
void main() {
  setUp(() {
    AppRouter.router.go(AppRouter.chooseRoleRoute);
  });
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) =>
          MaterialApp.router(routerConfig: AppRouter.router),
    );
  }
  Future<void> pumpChooseRoleView(WidgetTester tester) async {
    tester.view
      ..physicalSize = const Size(375, 1400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
  }
  group('ChooseRoleView integration flow', () {
    testWidgets('opens the choose-role route with both role options', (
      tester,
    ) async {
      await pumpChooseRoleView(tester);
      expect(find.byType(ChooseRoleView), findsOneWidget);
      expect(find.text('مرحبًا بك 👋'), findsOneWidget);
      expect(
        find.text(
          'منصة تربط بين المستخدمين ومقدمي الخدمات الرقمية بسهولة وأمان.',
        ),
        findsOneWidget,
      );
      expect(find.text('مستخدم'), findsOneWidget);
      expect(find.text('مقدم خدمة'), findsOneWidget);
      expect(find.byType(RoleCard), findsNWidgets(2));
    });
    testWidgets('accepts a user role selection without crashing', (
      tester,
    ) async {
      await pumpChooseRoleView(tester);
      await tester.tap(find.text('مستخدم'));
      await tester.pump();
      expect(find.byType(ChooseRoleView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
    testWidgets('accepts a provider role selection without crashing', (
      tester,
    ) async {
      await pumpChooseRoleView(tester);
      await tester.tap(find.text('مقدم خدمة'));
      await tester.pump();
      expect(find.byType(ChooseRoleView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}