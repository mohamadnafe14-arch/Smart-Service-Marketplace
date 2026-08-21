// test/features/auth/view/widgets/auth_body_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/auth_body.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/sign_in_body.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/sign_up_body.dart';
Future<void> pumpAuthBody(WidgetTester tester) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(
        home: Scaffold(
          body: AuthBody(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
void main() {
  group('AuthBody widget tests', () {
    testWidgets(
      'renders welcome title and subtitle texts',
      (WidgetTester tester) async {
        await pumpAuthBody(tester);
        expect(find.text('مرحبا بك في سوق الخدمات الرقمية'), findsOneWidget);
        expect(find.text('يرجي ادخال بياناتك بعناية'), findsOneWidget);
      },
    );
    testWidgets(
      'renders both auth toggle buttons with correct labels',
      (WidgetTester tester) async {
        await pumpAuthBody(tester);
        expect(find.text('انشاء حساب'), findsOneWidget);
        expect(find.text('تسجيل الدخول'), findsOneWidget);
      },
    );
    testWidgets(
      'shows SignInBody by default (signIn = true initially)',
      (WidgetTester tester) async {
        await pumpAuthBody(tester);
        expect(find.byType(SignInBody), findsOneWidget);
        expect(find.byType(SignUpBody), findsNothing);
      },
    );
    testWidgets(
      'tapping "انشاء حساب" switches to SignUpBody',
      (WidgetTester tester) async {
        await pumpAuthBody(tester);
        expect(find.byType(SignInBody), findsOneWidget);
        expect(find.byType(SignUpBody), findsNothing);
        await tester.tap(find.text('انشاء حساب'));
        await tester.pumpAndSettle();
        expect(find.byType(SignUpBody), findsOneWidget);
        expect(find.byType(SignInBody), findsNothing);
      },
    );
    testWidgets(
      'tapping "تسجيل الدخول" after switching to sign up goes back to SignInBody',
      (WidgetTester tester) async {
        await pumpAuthBody(tester);
        await tester.tap(find.text('انشاء حساب'));
        await tester.pumpAndSettle();
        expect(find.byType(SignUpBody), findsOneWidget);
        await tester.tap(find.text('تسجيل الدخول'));
        await tester.pumpAndSettle();
        expect(find.byType(SignInBody), findsOneWidget);
        expect(find.byType(SignUpBody), findsNothing);
      },
    );
    testWidgets(
      'tapping the currently active tab again keeps the same body shown',
      (WidgetTester tester) async {
        await pumpAuthBody(tester);
        await tester.tap(find.text('تسجيل الدخول'));
        await tester.pumpAndSettle();
        expect(find.byType(SignInBody), findsOneWidget);
        expect(find.byType(SignUpBody), findsNothing);
      },
    );
  });
}