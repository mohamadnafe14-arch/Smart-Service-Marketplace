import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_market_place/features/orders/view/widgets/custom_action_button.dart';


void main() {
  // Helper to wrap the widget with ScreenUtilInit + MaterialApp,
  // since CustomActionButton relies on .r / .w extensions from screenutil.
  Widget buildTestable(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  group('CustomActionButton', () {
    testWidgets('renders the given text', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Continue',
            color: Colors.blue,
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Submit',
            color: Colors.green,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(CustomActionButton));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('applies the given background color to Material', (tester) async {
      const testColor = Colors.red;

      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Delete',
            color: testColor,
            onTap: () {},
          ),
        ),
      );

      final materialFinder = find.descendant(
        of: find.byType(CustomActionButton),
        matching: find.byType(Material),
      );

      expect(materialFinder, findsOneWidget);

      final material = tester.widget<Material>(materialFinder);
      expect(material.color, testColor);
    });

    testWidgets('renders text with white color and bold weight', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Confirm',
            color: Colors.purple,
            onTap: () {},
          ),
        ),
      );

      final textFinder = find.descendant(
        of: find.byType(CustomActionButton),
        matching: find.text('Confirm'),
      );

      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.color, Colors.white);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('has rounded corners via Material', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Rounded',
            color: Colors.orange,
            onTap: () {},
          ),
        ),
      );

      final materialFinder = find.descendant(
        of: find.byType(CustomActionButton),
        matching: find.byType(Material),
      );

      final material = tester.widget<Material>(materialFinder);
      expect(material.borderRadius, BorderRadius.circular(12.r));
    });

    testWidgets('InkWell also has matching rounded corners', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Rounded',
            color: Colors.orange,
            onTap: () {},
          ),
        ),
      );

      final inkWellFinder = find.descendant(
        of: find.byType(CustomActionButton),
        matching: find.byType(InkWell),
      );

      expect(inkWellFinder, findsOneWidget);

      final inkWell = tester.widget<InkWell>(inkWellFinder);
      expect(inkWell.borderRadius, BorderRadius.circular(12.r));
    });

    testWidgets('handles empty text gracefully', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: '',
            color: Colors.grey,
            onTap: () {},
          ),
        ),
      );

      final textFinder = find.descendant(
        of: find.byType(CustomActionButton),
        matching: find.byType(Text),
      );

      expect(textFinder, findsOneWidget);
      expect(tester.widget<Text>(textFinder).data, '');
    });

    testWidgets('does not throw when tapped multiple times rapidly', (tester) async {
      var tapCount = 0;

      await tester.pumpWidget(
        buildTestable(
          CustomActionButton(
            text: 'Tap Me',
            color: Colors.teal,
            onTap: () => tapCount++,
          ),
        ),
      );

      await tester.tap(find.byType(CustomActionButton));
      await tester.tap(find.byType(CustomActionButton));
      await tester.tap(find.byType(CustomActionButton));
      await tester.pump();

      expect(tapCount, 3);
    });
  });
}