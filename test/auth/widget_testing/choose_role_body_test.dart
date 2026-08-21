import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/choose_role_body.dart';
void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: ChooseRoleBody(),
      ),
    );
  }
  group('ChooseRoleBody Widget Tests', () {
    testWidgets('renders welcome title and subtitle text',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      expect(find.text('مرحبًا بك 👋'), findsOneWidget);
      expect(
        find.text('منصة تربط بين المستخدمين ومقدمي الخدمات الرقمية بسهولة وأمان.'),
        findsOneWidget,
      );
    });
    testWidgets('renders both role cards with correct titles and descriptions',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      expect(find.text('مستخدم'), findsOneWidget);
      expect(find.text('اطلب خدماتك بسهولة من أفضل مقدمي الخدمات.'),
          findsOneWidget);
      expect(find.text('مقدم خدمة'), findsOneWidget);
      expect(find.text('اعرض خدماتك وابدأ في تحقيق أرباح.'), findsOneWidget);
    });
    testWidgets('renders correct icons for each role card',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.work), findsOneWidget);
    });
    testWidgets('animation controller runs fade and slide animations',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('مرحبًا بك 👋'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 1200));
      await tester.pumpAndSettle();
      expect(find.text('مرحبًا بك 👋'), findsOneWidget);
    });
    testWidgets('tapping user role card triggers onTap callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      final userCard = find.text('مستخدم');
      expect(userCard, findsOneWidget);
      await tester.tap(userCard);
      await tester.pumpAndSettle();
    });
    testWidgets('tapping provider role card triggers onTap callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      final providerCard = find.text('مقدم خدمة');
      expect(providerCard, findsOneWidget);
      await tester.tap(providerCard);
      await tester.pumpAndSettle();
    });
    testWidgets('disposes animation controller without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      await tester.pumpAndSettle();
    });
  });
}