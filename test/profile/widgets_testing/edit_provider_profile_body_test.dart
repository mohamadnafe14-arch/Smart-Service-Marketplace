import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/edit_provider_profile_body.dart';

Widget makeTestableWidget({required String token}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, child) {
      return MaterialApp(
        locale: const Locale('ar'),
        home: Scaffold(
          body: EditProviderProfileBody(token: token),
        ),
      );
    },
  );
}

void main() {
  group('EditProviderProfileBody', () {
    // The form's content is taller than the default 800x600 test surface,
    // which pushes the save button off-screen and makes tap() a no-op.
    // Give every test a generous viewport, and restore it afterwards.
    setUp(() async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      // ignore: deprecated_member_use
      binding.window.physicalSizeTestValue = const Size(1080, 2400);
      // ignore: deprecated_member_use
      binding.window.devicePixelRatioTestValue = 1.0;
      // ignore: deprecated_member_use
      addTearDown(binding.window.clearPhysicalSizeTestValue);
      // ignore: deprecated_member_use
      addTearDown(binding.window.clearDevicePixelRatioTestValue);
    });

    final dropdownFinder = find.byType(DropdownButtonFormField<String>);
    final saveButtonFinder = find.text('حفظ التغييرات');

    testWidgets('renders all field labels', (tester) async {
      await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
      await tester.pumpAndSettle();

      expect(find.text('الاسم'), findsOneWidget);
      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('المدينة'), findsOneWidget);
      expect(find.text('الشارع'), findsOneWidget);
      expect(find.text('العنوان بالتفصيل'), findsOneWidget);
      expect(find.text('الفئة'), findsOneWidget);
      expect(find.text('الخبرة'), findsOneWidget);
    });

    testWidgets('renders initial values from userInformation', (tester) async {
      await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
      await tester.pumpAndSettle();

      expect(find.text('name'), findsOneWidget);
      expect(find.text('phone'), findsOneWidget);
      expect(find.text('city'), findsOneWidget);
      expect(find.text('street'), findsOneWidget);
      expect(find.text('addressInDetails'), findsOneWidget);
      expect(find.text('experience'), findsOneWidget);
    });

    testWidgets('renders the save button', (tester) async {
      await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
      await tester.pumpAndSettle();

      expect(saveButtonFinder, findsOneWidget);
    });

    testWidgets(
      'shows validation error when name is cleared and form submitted',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
        await tester.pumpAndSettle();

        final nameField = find.byType(TextFormField).first;
        await tester.enterText(nameField, '');
        await tester.pumpAndSettle();

        await tester.ensureVisible(saveButtonFinder);
        await tester.tap(saveButtonFinder);
        await tester.pumpAndSettle();

        expect(find.text('الاسم بالكامل مطلوب'), findsOneWidget);
      },
    );

    testWidgets(
      'shows validation error for invalid phone number',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
        await tester.pumpAndSettle();

        final phoneField = find.byType(TextFormField).at(1);
        await tester.enterText(phoneField, '12345');
        await tester.pumpAndSettle();

        await tester.ensureVisible(saveButtonFinder);
        await tester.tap(saveButtonFinder);
        await tester.pumpAndSettle();

        expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsOneWidget);
      },
    );

    testWidgets(
      'accepts a valid Egyptian phone number without error',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
        await tester.pumpAndSettle();

        final phoneField = find.byType(TextFormField).at(1);
        await tester.enterText(phoneField, '01012345678');
        await tester.pumpAndSettle();

        await tester.ensureVisible(saveButtonFinder);
        await tester.tap(saveButtonFinder);
        await tester.pumpAndSettle();

        expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsNothing);
      },
    );

    testWidgets(
      'shows validation error when category is not selected',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
        await tester.pumpAndSettle();

        await tester.ensureVisible(saveButtonFinder);
        await tester.tap(saveButtonFinder);
        await tester.pumpAndSettle();

        expect(find.text('يرجي اختيار الفئة'), findsOneWidget);
      },
    );

    testWidgets('can select a category from the dropdown', (tester) async {
      await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(dropdownFinder);
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.text('البرمجة').last);
      await tester.pumpAndSettle();

      expect(find.text('البرمجة'), findsWidgets);
    });

    testWidgets(
      'no validation errors shown when all fields are valid',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(token: 'test_token'));
        await tester.pumpAndSettle();

        final phoneField = find.byType(TextFormField).at(1);
        await tester.enterText(phoneField, '01099999999');
        await tester.pumpAndSettle();

        await tester.ensureVisible(dropdownFinder);
        await tester.tap(dropdownFinder);
        await tester.pumpAndSettle();
        await tester.tap(find.text('الكهرباء').last);
        await tester.pumpAndSettle();

        await tester.ensureVisible(saveButtonFinder);
        await tester.tap(saveButtonFinder);
        await tester.pumpAndSettle();

        expect(find.text('الاسم بالكامل مطلوب'), findsNothing);
        expect(find.text('رقم الهاتف مطلوب'), findsNothing);
        expect(find.text('يرجي ادخال رقم هاتف صحيح'), findsNothing);
        expect(find.text('المدينة مطلوبة'), findsNothing);
        expect(find.text('الشارع مطلوب'), findsNothing);
        expect(find.text('العنوان بالتفصيل مطلوب'), findsNothing);
        expect(find.text('يرجي اختيار الفئة'), findsNothing);
        expect(find.text('الخبرة مطلوبة'), findsNothing);
      },
    );
  });
}