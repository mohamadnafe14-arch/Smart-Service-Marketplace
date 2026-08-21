import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/sign_up_body.dart';
Future<void> pumpSignUpBody(WidgetTester tester) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        locale: const Locale('ar'),
        home: const Scaffold(body: SignUpBody()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
Finder fieldAt(int index) => find.byType(TextFormField).at(index);
void main() {
  group('SignUpBody widget tests', () {
    testWidgets('renders all expected fields, labels and buttons',
        (tester) async {
      await pumpSignUpBody(tester);
      expect(find.text('الاسم بالكامل'), findsOneWidget);
      expect(find.text('البريد الالكتروني'), findsOneWidget);
      expect(find.text('كلمة المرور'), findsOneWidget);
      expect(find.text('يمكنك ايضا المتابعة باستخدام'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.text('ابدأ الان'), findsOneWidget);
      expect(find.byType(ElevatedButton).evaluate().isNotEmpty ||
          find.text('ابدأ الان').evaluate().isNotEmpty, isTrue);
    });

    testWidgets('shows validation errors when submitting an empty form',
        (tester) async {
      await pumpSignUpBody(tester);
      await tester.tap(find.text('ابدأ الان'));
      await tester.pumpAndSettle();
      expect(find.text('الاسم بالكامل مطلوب'), findsOneWidget);
      expect(find.text('يرجي ادخال البريد الالكتروني'), findsOneWidget);
      expect(find.text('يرجي ادخال كلمة المرور'), findsOneWidget);
    });
    testWidgets('shows email format error for invalid email', (tester) async {
      await pumpSignUpBody(tester);
      await tester.enterText(fieldAt(1), 'not-an-email');
      await tester.tap(find.text('ابدأ الان'));
      await tester.pumpAndSettle();
      expect(find.text('يرجي ادخال بريد الالكتروني صحيح'), findsOneWidget);
    });
    testWidgets(
        'shows domain error when email is valid format but wrong domain',
        (tester) async {
      await pumpSignUpBody(tester);
      await tester.enterText(fieldAt(1), 'test@gmail.com');
      await tester.tap(find.text('ابدأ الان'));
      await tester.pumpAndSettle();
      expect(find.text("يرجي ادحال بريد ينتهي ب'@stm.com'"), findsOneWidget);
    });
    testWidgets('accepts a valid @stm.com email with no domain/format error',
        (tester) async {
      await pumpSignUpBody(tester);
      await tester.enterText(fieldAt(0), 'Ahmed Ali');
      await tester.enterText(fieldAt(1), 'ahmed@stm.com');
      await tester.enterText(fieldAt(2), 'Password123');
      await tester.tap(find.text('ابدأ الان'));
      await tester.pumpAndSettle();
      expect(find.text('الاسم بالكامل مطلوب'), findsNothing);
      expect(find.text('يرجي ادخال البريد الالكتروني'), findsNothing);
      expect(find.text('يرجي ادخال بريد الالكتروني صحيح'), findsNothing);
      expect(find.text("يرجي ادحال بريد ينتهي ب'@stm.com'"), findsNothing);
      expect(find.text('يرجي ادخال كلمة المرور'), findsNothing);
    });
    testWidgets('typing in fields updates internal onChanged state (no crash)',
        (tester) async {
      await pumpSignUpBody(tester);
      await tester.enterText(fieldAt(0), 'Sara');
      await tester.enterText(fieldAt(1), 'sara@stm.com');
      await tester.enterText(fieldAt(2), 'mypassword');
      await tester.pump();
      expect(find.text('Sara'), findsOneWidget);
      expect(find.text('sara@stm.com'), findsOneWidget);
      expect(find.text('mypassword'), findsOneWidget);
    });
    testWidgets('form does not call save when validation fails',
        (tester) async {
      await pumpSignUpBody(tester);
      await tester.enterText(fieldAt(0), 'Only Name');
      await tester.tap(find.text('ابدأ الان'));
      await tester.pumpAndSettle();
      expect(find.text('يرجي ادخال البريد الالكتروني'), findsOneWidget);
      expect(find.text('يرجي ادخال كلمة المرور'), findsOneWidget);
    });
    testWidgets('renders a Google sign-up button', (tester) async {
      await pumpSignUpBody(tester);
      expect(find.byWidgetPredicate((w) => w.runtimeType.toString() == 'GoogleButton'),
          findsOneWidget);
    });
    testWidgets('tapping Google button does not throw (empty onPressed stub)',
        (tester) async {
      await pumpSignUpBody(tester);
      final googleButtonFinder =
          find.byWidgetPredicate((w) => w.runtimeType.toString() == 'GoogleButton');
      expect(googleButtonFinder, findsOneWidget);
      await tester.tap(googleButtonFinder);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
    testWidgets('password field obscures text', (tester) async {
      await pumpSignUpBody(tester);
      final textFieldFinder = find.descendant(
        of: fieldAt(2),
        matching: find.byType(EditableText),
      );
      final editableText = tester.widget<EditableText>(textFieldFinder);
      expect(editableText.obscureText, isTrue);
    });
  });
}