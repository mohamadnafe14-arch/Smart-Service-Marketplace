import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/sign_in_body.dart';
void main() {
  Future<void> pumpSignInBody(WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: SignInBody(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }
  group('SignInBody widget tests', () {
    testWidgets('renders all expected fields and buttons', (tester) async {
      await pumpSignInBody(tester);
      expect(find.text('البريد الالكتروني'), findsOneWidget);
      expect(find.text('كلمة المرور'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('ابدأ الان'), findsOneWidget);
      expect(find.text('يمكنك ايضا المتابعة باستخدام'), findsOneWidget);
      expect(find.byType(Row), findsWidgets);
    });
    testWidgets(
      'shows validation errors when submitting empty form',
      (tester) async {
        await pumpSignInBody(tester);
        await tester.tap(find.text('ابدأ الان'));
        await tester.pumpAndSettle();
        expect(find.text('يرجي ادخال البريد الالكتروني'), findsOneWidget);
        expect(find.text('يرجي ادخال كلمة المرور'), findsOneWidget);
      },
    );
    testWidgets(
      'shows error when email format is invalid',
      (tester) async {
        await pumpSignInBody(tester);
        final emailField = find.byType(TextFormField).first;
        await tester.enterText(emailField, 'not-an-email');
        await tester.tap(find.text('ابدأ الان'));
        await tester.pumpAndSettle();
        expect(find.text('يرجي ادخال بريد الالكتروني صحيح'), findsOneWidget);
      },
    );
    testWidgets(
      'shows error when email does not end with @stm.com',
      (tester) async {
        await pumpSignInBody(tester);
        final emailField = find.byType(TextFormField).first;
        await tester.enterText(emailField, 'user@gmail.com');
        await tester.tap(find.text('ابدأ الان'));
        await tester.pumpAndSettle();
        expect(find.text("يرجي ادحال بريد ينتهي ب'@stm.com'"), findsOneWidget);
      },
    );
    testWidgets(
      'passes validation with valid @stm.com email and non-empty password',
      (tester) async {
        await pumpSignInBody(tester);
        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), 'user@stm.com');
        await tester.enterText(fields.at(1), 'somePassword123');
        await tester.tap(find.text('ابدأ الان'));
        await tester.pumpAndSettle();
        expect(find.text('يرجي ادخال البريد الالكتروني'), findsNothing);
        expect(find.text('يرجي ادخال بريد الالكتروني صحيح'), findsNothing);
        expect(find.text("يرجي ادحال بريد ينتهي ب'@stm.com'"), findsNothing);
        expect(find.text('يرجي ادخال كلمة المرور'), findsNothing);
      },
    );
    testWidgets(
      'password field obscures text when isPassword is true',
      (tester) async {
        await pumpSignInBody(tester);
        final passwordFieldFinder = find.byType(TextFormField).at(1);
        final editableText = tester.widget<EditableText>(
          find.descendant(
            of: passwordFieldFinder,
            matching: find.byType(EditableText),
          ),
        );
        expect(editableText.obscureText, isTrue);
      },
    );
    testWidgets('email field is not obscured', (tester) async {
      await pumpSignInBody(tester);
      final emailFieldFinder = find.byType(TextFormField).at(0);
      final editableText = tester.widget<EditableText>(
        find.descendant(
          of: emailFieldFinder,
          matching: find.byType(EditableText),
        ),
      );
      expect(editableText.obscureText, isFalse);
    });
  });
}