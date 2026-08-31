import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/edit_user_profile_body.dart';

/// Helper to pump [EditUserProfileBody] wrapped with the ScreenUtilInit
/// dependency it relies on for `.w`, `.h`, `.sp` extensions.
Future<void> pumpEditUserProfileBody(WidgetTester tester) async {
  // Enlarge the test viewport so the scrollable content + save button
  // fit within the hit-testable render tree bounds.
  await tester.binding.setSurfaceSize(const Size(400, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: EditUserProfileBody(token: 'test_token'),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Scrolls the save button into view (in case it's below the fold in the
/// SingleChildScrollView) then taps it.
Future<void> tapSaveButton(WidgetTester tester) async {
  final saveButton = find.text('حفظ التغييرات');
  await tester.ensureVisible(saveButton);
  await tester.pumpAndSettle();
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}

void main() {
  group('EditUserProfileBody', () {
    testWidgets('renders all field labels', (tester) async {
      await pumpEditUserProfileBody(tester);

      expect(find.text('الاسم'), findsOneWidget);
      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('المدينة'), findsOneWidget);
      expect(find.text('الشارع'), findsOneWidget);
      expect(find.text('العنوان بالتفصيل'), findsOneWidget);
    });

    testWidgets('renders all 5 text form fields with initial values',
        (tester) async {
      await pumpEditUserProfileBody(tester);

      expect(find.byType(TextFormField), findsNWidgets(5));

      // Hardcoded userInformation values from the widget (TODO: cubit wiring).
      expect(find.text('name'), findsOneWidget);
      expect(find.text('phone'), findsOneWidget);
      expect(find.text('city'), findsOneWidget);
      expect(find.text('street'), findsOneWidget);
      expect(find.text('addressInDetails'), findsOneWidget);
    });

    testWidgets('renders save button with correct label', (tester) async {
      await pumpEditUserProfileBody(tester);

      expect(find.text('حفظ التغييرات'), findsOneWidget);
    });

    testWidgets('shows validation error when name is cleared', (tester) async {
      await pumpEditUserProfileBody(tester);

      final nameField = find.byType(TextFormField).at(0);
      await tester.enterText(nameField, '');
      await tapSaveButton(tester);

      expect(find.text('الاسم بالكامل مطلوب'), findsOneWidget);
    });

    testWidgets('shows validation error when phone is invalid', (tester) async {
      await pumpEditUserProfileBody(tester);

      final phoneField = find.byType(TextFormField).at(1);
      await tester.enterText(phoneField, '12345');
      await tapSaveButton(tester);

      expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsOneWidget);
    });

    testWidgets('shows no phone validation error for valid Egyptian number',
        (tester) async {
      await pumpEditUserProfileBody(tester);

      final phoneField = find.byType(TextFormField).at(1);
      await tester.enterText(phoneField, '01012345678');
      await tapSaveButton(tester);

      expect(find.text('رقم الهاتف مطلوب'), findsNothing);
      expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsNothing);
    });

    testWidgets('shows validation error when phone is empty', (tester) async {
      await pumpEditUserProfileBody(tester);

      final phoneField = find.byType(TextFormField).at(1);
      await tester.enterText(phoneField, '');
      await tapSaveButton(tester);

      expect(find.text('رقم الهاتف مطلوب'), findsOneWidget);
    });

    testWidgets('shows validation error when city is cleared', (tester) async {
      await pumpEditUserProfileBody(tester);

      final cityField = find.byType(TextFormField).at(2);
      await tester.enterText(cityField, '');
      await tapSaveButton(tester);

      expect(find.text('المدينة مطلوبة'), findsOneWidget);
    });

    testWidgets('shows validation error when street is cleared', (tester) async {
      await pumpEditUserProfileBody(tester);

      final streetField = find.byType(TextFormField).at(3);
      await tester.enterText(streetField, '');
      await tapSaveButton(tester);

      expect(find.text('الشارع مطلوب'), findsOneWidget);
    });

    testWidgets('shows validation error when addressInDetails is cleared',
        (tester) async {
      await pumpEditUserProfileBody(tester);

      final addressField = find.byType(TextFormField).at(4);
      await tester.enterText(addressField, '');
      await tapSaveButton(tester);

      expect(find.text('العنوان بالتفصيل مطلوب'), findsOneWidget);
    });

    testWidgets(
        'form passes validation when all fields are filled with valid data',
        (tester) async {
      await pumpEditUserProfileBody(tester);

      await tester.enterText(find.byType(TextFormField).at(0), 'Ahmed Ali');
      await tester.enterText(find.byType(TextFormField).at(1), '01123456789');
      await tester.enterText(find.byType(TextFormField).at(2), 'Cairo');
      await tester.enterText(find.byType(TextFormField).at(3), 'Tahrir St.');
      await tester.enterText(
          find.byType(TextFormField).at(4), 'Building 5, Floor 2');

      await tapSaveButton(tester);

      expect(find.text('الاسم بالكامل مطلوب'), findsNothing);
      expect(find.text('رقم الهاتف مطلوب'), findsNothing);
      expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsNothing);
      expect(find.text('المدينة مطلوبة'), findsNothing);
      expect(find.text('الشارع مطلوب'), findsNothing);
      expect(find.text('العنوان بالتفصيل مطلوب'), findsNothing);
    });

    testWidgets('scroll view exists so keyboard does not overflow layout',
        (tester) async {
      await pumpEditUserProfileBody(tester);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    group('phone number regex edge cases', () {
      final validPrefixes = ['010', '011', '012', '015'];
      final invalidPrefixes = ['013', '014', '016', '020', '099'];

      for (final prefix in validPrefixes) {
        testWidgets('accepts valid prefix $prefix', (tester) async {
          await pumpEditUserProfileBody(tester);
          final phoneField = find.byType(TextFormField).at(1);
          await tester.enterText(phoneField, '${prefix}12345678');
          await tapSaveButton(tester);
          expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsNothing);
        });
      }

      for (final prefix in invalidPrefixes) {
        testWidgets('rejects invalid prefix $prefix', (tester) async {
          await pumpEditUserProfileBody(tester);
          final phoneField = find.byType(TextFormField).at(1);
          await tester.enterText(phoneField, '${prefix}12345678');
          await tapSaveButton(tester);
          expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsOneWidget);
        });
      }
    });
  });
}