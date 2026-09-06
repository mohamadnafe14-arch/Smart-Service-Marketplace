import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/core/widgets/custom_button.dart';
import 'package:smart_service_market_place/features/services/model/models/make_order_param.dart';
import 'package:smart_service_market_place/features/services/view/widgets/make_order_dialog.dart';

void main() {
  // Helper to pump the dialog inside a properly-sized, screenutil-initialized app.
  Future<void> pumpDialog(
    WidgetTester tester, {
    required MakeOrderParam param,
  }) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          // Arabic RTL layout, matching the widget's text content.
          locale: const Locale('ar'),
          home: Scaffold(
            body: Center(child: MakeOrderDialog(makeOrderParam: param)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('MakeOrderDialog', () {
    testWidgets('renders phone and description fields with correct labels', (
      tester,
    ) async {
      var popped = false;
      final param = MakeOrderParam(
        phone: 'لم يتم تحديد الهاتف',
        pop: () => popped = true,
        providerId: 'provider123',
        token: 'token123',
      );

      await pumpDialog(tester, param: param);

      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('الوصف'), findsOneWidget);
      expect(find.byType(CustomButton), findsOneWidget);
      expect(find.byIcon(Icons.chat), findsOneWidget);
      expect(popped, isFalse);
    });

    testWidgets(
      'pre-fills phone field when a valid initial phone is provided',
      (tester) async {
        final param = MakeOrderParam(
          phone: '01012345678',
          pop: () {},
          providerId: 'provider123',
          token: 'token123',
        );

        await pumpDialog(tester, param: param);

        expect(find.text('01012345678'), findsOneWidget);
      },
    );

    testWidgets(
      'does not pre-fill phone field when placeholder "لم يتم تحديد الهاتف" is passed',
      (tester) async {
        final param = MakeOrderParam(
          phone: 'لم يتم تحديد الهاتف',
          pop: () {},
          providerId: 'provider123',
          token: 'token123',
        );

        await pumpDialog(tester, param: param);

        // The placeholder text itself should not appear as field content.
        expect(find.text('لم يتم تحديد الهاتف'), findsNothing);
      },
    );

    testWidgets('shows validation errors when submitting an empty form', (
      tester,
    ) async {
      var popped = false;
      final param = MakeOrderParam(
        phone: 'لم يتم تحديد الهاتف',
        pop: () => popped = true,
        providerId: 'provider123',
        token: 'token123',
      );

      await pumpDialog(tester, param: param);

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(find.text('يرجي ادخال رقم الهاتف'), findsOneWidget);
      expect(find.text('يرجي ادخال الوصف'), findsOneWidget);
      expect(popped, isFalse);
    });

    testWidgets('shows validation error for an invalid phone number format', (
      tester,
    ) async {
      final param = MakeOrderParam(
        phone: 'لم يتم تحديد الهاتف',
        pop: () {},
        providerId: 'provider123',
        token: 'token123',
      );

      await pumpDialog(tester, param: param);

      final phoneField = find.byType(TextFormField).first;
      await tester.enterText(phoneField, '12345');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsOneWidget);
    });

    testWidgets(
      'accepts a valid phone number and does not show phone validation error',
      (tester) async {
        final param = MakeOrderParam(
          phone: 'لم يتم تحديد الهاتف',
          pop: () {},
          providerId: 'provider123',
          token: 'token123',
        );

        await pumpDialog(tester, param: param);

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), '01123456789');
        await tester.enterText(fields.at(1), 'وصف الخدمة المطلوبة');

        await tester.tap(find.byType(CustomButton));
        await tester.pumpAndSettle();

        expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsNothing);
        expect(find.text('يرجي ادخال رقم الهاتف'), findsNothing);
        expect(find.text('يرجي ادخال الوصف'), findsNothing);
      },
    );

    testWidgets('calls pop callback and shows success message on valid submit', (
      tester,
    ) async {
      var popped = false;
      final param = MakeOrderParam(
        phone: 'لم يتم تحديد الهاتف',
        pop: () => popped = true,
        providerId: 'provider123',
        token: 'token123',
      );

      await pumpDialog(tester, param: param);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '01123456789');
      await tester.enterText(fields.at(1), 'وصف الخدمة المطلوبة');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(popped, isTrue);
      // The success snackbar/toast text should be shown somewhere in the tree.
      expect(find.text('تم عمل الطلب بنجاح'), findsOneWidget);
    });

    testWidgets('chat icon button is tappable without throwing', (
      tester,
    ) async {
      final param = MakeOrderParam(
        phone: 'لم يتم تحديد الهاتف',
        pop: () {},
        providerId: 'provider123',
        token: 'token123',
      );

      await pumpDialog(tester, param: param);

      await tester.tap(find.byIcon(Icons.chat));
      await tester.pumpAndSettle();

      // Currently a no-op handler; this just guards against regressions
      // (e.g. someone adding logic that throws).
      expect(tester.takeException(), isNull);
    });
  });
}
