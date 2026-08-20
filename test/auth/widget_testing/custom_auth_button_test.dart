import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/custom_auth_button.dart';
void main() {
  Widget createWidgetUnderTest({
    required String text,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => CustomAuthButton(
            text: text,
            isActive: isActive,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
  group('CustomAuthButton', () {
    testWidgets('renders the given text', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          text: 'Sign In',
          isActive: false,
          onPressed: () {},
        ),
      );
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
    testWidgets('calls onPressed when tapped', (tester) async {
      var wasPressed = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          text: 'Continue',
          isActive: false,
          onPressed: () => wasPressed = true,
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(wasPressed, isTrue);
    });
    testWidgets('applies active style (grey background, black text) when isActive is true',
        (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          text: 'Active',
          isActive: true,
          onPressed: () {},
        ),
      );

      final buttonWidget = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = buttonWidget.style!;
      final backgroundColor = style.backgroundColor!.resolve({});
      expect(backgroundColor, Colors.grey);
      final textWidget = tester.widget<Text>(find.text('Active'));
      expect(textWidget.style?.color, Colors.black);
    });
    testWidgets('applies inactive style (white background, blue text) when isActive is false',
        (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          text: 'Inactive',
          isActive: false,
          onPressed: () {},
        ),
      );
      final buttonWidget = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = buttonWidget.style!;
      final backgroundColor = style.backgroundColor!.resolve({});
      expect(backgroundColor, Colors.white);
      final textWidget = tester.widget<Text>(find.text('Inactive'));
      expect(textWidget.style?.color, Colors.blue);
    });
    testWidgets('has rounded rectangle border shape', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          text: 'Shape Test',
          isActive: false,
          onPressed: () {},
        ),
      );
      final buttonWidget = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final shape = buttonWidget.style!.shape!.resolve({}) as RoundedRectangleBorder;
      expect(shape.borderRadius, isA<BorderRadius>());
    });
    testWidgets('onPressed still triggers regardless of isActive value', (tester) async {
      var tapCount = 0;
      await tester.pumpWidget(
        createWidgetUnderTest(
          text: 'Tap Me',
          isActive: true,
          onPressed: () => tapCount++,
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(tapCount, 1);
    });
  });
}