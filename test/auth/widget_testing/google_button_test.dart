import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/google_button.dart';
void main() {
  Widget wrapInApp(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }
  group('GoogleButton', () {
    testWidgets('renders icon and text when not loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapInApp(GoogleButton(onPressed: () {})));
      expect(find.text('oogle'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
    testWidgets('shows CircularProgressIndicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapInApp(GoogleButton(onPressed: () {}, isLoading: true)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('oogle'), findsNothing);
    });
    testWidgets('calls onPressed when tapped and not loading', (
      WidgetTester tester,
    ) async {
      var wasPressed = false;
      await tester.pumpWidget(
        wrapInApp(
          GoogleButton(
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(wasPressed, isTrue);
    });
    testWidgets('does not call onPressed when isLoading is true', (
      WidgetTester tester,
    ) async {
      var wasPressed = false;
      await tester.pumpWidget(
        wrapInApp(
          GoogleButton(
            onPressed: () {
              wasPressed = true;
            },
            isLoading: true,
          ),
        ),
      );
      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();
      expect(wasPressed, isFalse);
    });
    testWidgets('button has correct background color and shape', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapInApp(GoogleButton(onPressed: () {})));
      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      final style = button.style!;
      final backgroundColor = style.backgroundColor?.resolve(<WidgetState>{});
      expect(backgroundColor, Colors.red[700]);
      final shape = style.shape?.resolve(<WidgetState>{});
      expect(shape, isA<RoundedRectangleBorder>());
      final rounded = shape as RoundedRectangleBorder;
      expect(
        (rounded.borderRadius as BorderRadius).topLeft,
        const Radius.circular(8),
      );
    });
    testWidgets('button spans full available width', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapInApp(GoogleButton(onPressed: () {})));
      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      final minSize = button.style!.minimumSize?.resolve(<WidgetState>{});
      expect(minSize, const Size(double.infinity, 50));
    });
  });
}
